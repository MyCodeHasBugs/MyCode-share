/*
 * sk_guard —— 抢在 ActivityManager 之前掐掉"对我方的 force-stop"
 *
 * 为什么不是 ptrace hook:
 *   探针实测 shell 域 CapEff=0, netlink connector(cn_proc) 被 SELinux 拒(EPERM);
 *   同 uid 兄弟进程可以 PTRACE_ATTACH, 但 adbd 挂不上(EPERM), 也就是说没有
 *   一个"所有 shell 命令都会经过"的挂点。能挂的只有某个具体的 shell 守护,
 *   而且一挂上就得让它按 syscall 停下来 —— 那是把对方拖死, 不是拦截。
 *
 * 实际可行的最短路径:
 *   force-stop 必须落地成一个 `am`/`cmd`/`app_process` 进程, 而它从 exec 到
 *   真的调到 ActivityManager 有 200~400ms(JVM 冷启动)。这里每 15ms 扫一次
 *   /proc, 发现新进程的命令行里同时出现 "force-stop" 和本包名, 立刻 SIGKILL,
 *   在它发出 binder 调用之前把它掐掉。
 *
 * 反杀:
 *   杀完 am 之后顺着 ppid 链往上走。如果链上出现 uid 2000、非 .sk/、且是常驻
 *   形态的祖先进程(别的"shell 软件"), 一并杀掉; 如果祖先进程的路径里能解析出
 *   包名(/data/data/<pkg>/ 或 /data/app/.../<pkg>-...), 再补一记
 *   `am force-stop <pkg>` —— 这就是"把强行停止对焦到别人身上"。
 *
 * 两条不碰的红线:
 *   1. 链上出现 adbd  => 这是用户从电脑上手敲的, 放行(否则你也没法手动停它);
 *   2. 解析出的包名 == 自己 => 永不下手。
 */
#include "sk_common.h"
#include <sys/ptrace.h>

#define GUARD_INTERVAL_US 10000
#define MAX_CHAIN 8

static int g_blocked = 0;

/* ------------------------------------------------------------ pid 位图 */

static unsigned char g_seen[32768 / 8];
static unsigned char g_cur[32768 / 8];

/*
 * 重检队列。
 *
 * 进程刚 fork 出来时 cmdline 还是**继承自父进程**的(比如 atk.sh), 等它 exec
 * 成 am 才变成我们关心的样子。如果第一次看到就永久标记"已看过", 就会整条漏掉 ——
 * 实测就是这样: 只杀到了 app_process, binder 已经发出去, App 照样被停。
 * 所以新 pid 要在一段时间内反复看。
 */
#define PEND_MAX 64
#define PEND_ROUNDS 30                  /* 30 × 10ms = 300ms 窗口 */
static struct {
    pid_t pid;
    int left;
} g_pend[PEND_MAX];
static int g_pend_n;

static int bit_get(const unsigned char *m, int pid)
{
    if (pid <= 0 || pid >= 32768) {
        return 0;
    }
    return (m[pid >> 3] >> (pid & 7)) & 1;
}

static void bit_set(unsigned char *m, int pid)
{
    if (pid > 0 && pid < 32768) {
        m[pid >> 3] |= (unsigned char) (1u << (pid & 7));
    }
}

static void pend_add(pid_t pid)
{
    for (int i = 0; i < g_pend_n; i++) {
        if (g_pend[i].pid == pid) {
            return;
        }
    }
    if (g_pend_n < PEND_MAX) {
        g_pend[g_pend_n].pid = pid;
        g_pend[g_pend_n].left = PEND_ROUNDS;
        g_pend_n++;
    }
}

static void pend_remove(int idx)
{
    g_pend[idx] = g_pend[g_pend_n - 1];
    g_pend_n--;
}

/* ------------------------------------------------------------ /proc 读 */

static int read_status(pid_t pid, int *uid, int *ppid)
{
    char path[64], buf[1024];
    snprintf(path, sizeof(path), "/proc/%d/status", (int) pid);
    if (sk_read_file(path, buf, sizeof(buf)) <= 0) {
        return -1;
    }
    char *p = strstr(buf, "\nUid:");
    *uid = p ? (int) strtol(p + 5, NULL, 10) : -1;
    p = strstr(buf, "\nPPid:");
    *ppid = p ? (int) strtol(p + 6, NULL, 10) : -1;
    return 0;
}

static int read_comm(pid_t pid, char *out, size_t sz)
{
    char path[64];
    snprintf(path, sizeof(path), "/proc/%d/comm", (int) pid);
    int n = sk_read_file(path, out, sz);
    if (n <= 0) {
        return -1;
    }
    char *nl = strchr(out, '\n');
    if (nl) {
        *nl = 0;
    }
    return 0;
}

/* ------------------------------------------------------ 包名 / 反杀 */

/* 从 /data/data/<pkg>/... 或 /data/app/~~x==/<pkg>-y==/... 里抠包名 */
static int pkg_from_cmd(const char *cmd, char *out, size_t sz)
{
    const char *p = strstr(cmd, "/data/data/");
    if (p) {
        p += 11;
        size_t i = 0;
        while (p[i] && p[i] != '/' && i + 1 < sz) {
            out[i] = p[i];
            i++;
        }
        out[i] = 0;
        return i > 0 ? 0 : -1;
    }
    p = strstr(cmd, "/data/user/0/");
    if (p) {
        p += 13;
        size_t i = 0;
        while (p[i] && p[i] != '/' && i + 1 < sz) {
            out[i] = p[i];
            i++;
        }
        out[i] = 0;
        return i > 0 ? 0 : -1;
    }
    /* /data/app/~~hash==/com.foo-bar==/base.apk -> com.foo */
    p = strstr(cmd, "/data/app/");
    if (p) {
        const char *slash = strchr(p + 10, '/');
        if (slash) {
            slash++;
            const char *dash = strchr(slash, '-');
            size_t len = dash ? (size_t) (dash - slash) : strlen(slash);
            if (len > 0 && len + 1 < sz) {
                memcpy(out, slash, len);
                out[len] = 0;
                /* 去掉可能残留的 == 尾巴 */
                char *eq = strstr(out, "==");
                if (eq) {
                    *eq = 0;
                }
                return out[0] ? 0 : -1;
            }
        }
    }
    return -1;
}

/*
 * 再从 /proc/<pid>/{cwd,exe,environ,maps} 里找一次包名。
 *
 * 对手把守护 daemon 化之后，cmdline 里常常只剩 "sh /data/local/tmp/x.sh"，
 * 应用包名只出现在工作目录、可执行文件、环境变量或 mmap 的文件路径里。
 * 这些都在同 uid(shell) 的可读范围内 —— 找到就能把 force-stop 打回它本体，
 * 而不是只杀一个随时会复活的 shell。
 */
static int pkg_from_proc(pid_t pid, char *out, size_t sz)
{
    char path[64], buf[8192];
    ssize_t n;

    snprintf(path, sizeof(path), "/proc/%d/cwd", (int) pid);
    n = readlink(path, buf, sizeof(buf) - 1);
    if (n > 0) {
        buf[n] = 0;
        if (pkg_from_cmd(buf, out, sz) == 0) {
            return 0;
        }
    }
    snprintf(path, sizeof(path), "/proc/%d/exe", (int) pid);
    n = readlink(path, buf, sizeof(buf) - 1);
    if (n > 0) {
        buf[n] = 0;
        if (pkg_from_cmd(buf, out, sz) == 0) {
            return 0;
        }
    }

    const char *files[] = { "/proc/%d/environ", "/proc/%d/maps", NULL };
    for (int i = 0; files[i]; i++) {
        snprintf(path, sizeof(path), files[i], (int) pid);
        int fd = open(path, O_RDONLY);
        if (fd < 0) {
            continue;
        }
        n = read(fd, buf, sizeof(buf) - 1);
        close(fd);
        if (n <= 0) {
            continue;
        }
        buf[n] = 0;
        for (ssize_t k = 0; k < n; k++) {
            if (buf[k] == 0) {
                buf[k] = '\n';          /* environ 是 NUL 分隔 */
            }
        }
        if (pkg_from_cmd(buf, out, sz) == 0) {
            return 0;
        }
    }
    return -1;
}

/*
 * 只认真正的"攻击本包"调用形态, 不能只看字符串:
 *   1. /system/bin/sh /system/bin/am force-stop ...   (am 是脚本)
 *   2. app_process ... com.android.commands.am.Am force-stop ...
 *   3. cmd activity force-stop ...
 *   4. pm uninstall / pm disable-user / pm clear / pm suspend
 *   5. cmd package uninstall / disable / clear / suspend
 * 否则一条 `echo "am force-stop com.sk.keeper"` 也会被当成攻击。
 *
 * 为什么要管 uninstall/disable/clear:
 *   真机上对手拿到 shell 之后不只用 force-stop, 还会直接
 *   `pm uninstall com.sk.keeper` 把包删掉, 或者 `pm disable-user` 让它
 *   起不来。这两种必须在 am/pm 真正调到 PackageManager 之前掐掉。
 */
static int is_attack_cmd(const char *cmd)
{
    if (strstr(cmd, SK_PKG) == NULL) {
        return 0;
    }

    int is_am = (strstr(cmd, "com.android.commands.am.Am") != NULL)
                || strncmp(cmd, "am ", 3) == 0
                || strstr(cmd, "/system/bin/am ") != NULL;
    if (is_am) {
        return strstr(cmd, "force-stop") != NULL || strstr(cmd, "force_stop") != NULL
               || strstr(cmd, "am kill ") != NULL || strstr(cmd, " kill ") != NULL;
    }

    int is_pkg_tool = (strncmp(cmd, "pm ", 3) == 0
                       || strstr(cmd, "/system/bin/pm ") != NULL
                       || strncmp(cmd, "cmd ", 4) == 0
                       || strstr(cmd, "/system/bin/cmd ") != NULL
                       || strstr(cmd, "com.android.commands.pm.Pm") != NULL
                       || strstr(cmd, "com.android.commands.cmd.Cmd") != NULL);
    if (is_pkg_tool) {
        return strstr(cmd, "uninstall") != NULL
               || strstr(cmd, "disable") != NULL
               || strstr(cmd, "clear") != NULL
               || strstr(cmd, "suspend") != NULL;
    }
    return 0;
}

static void note_block(const char *why, const char *detail)
{
    g_blocked++;
    char num[32];
    snprintf(num, sizeof(num), "%d", g_blocked);
    sk_write_str(SK_STATE "/blocked", num);
    sk_write_str(SK_STATE "/blocked_last", detail);
    sk_event("%s %s", why, detail);
}

/*
 * 处理一次拦截。返回 1 表示已经掐掉。
 * 先把祖先链读出来再动手 —— 杀掉 am 之后 /proc/<pid> 立刻就没了。
 */
static int handle_hit(pid_t pid, const char *cmd)
{
    pid_t chain[MAX_CHAIN];
    int uid[MAX_CHAIN];
    char comm[MAX_CHAIN][32];
    int depth = 0;
    int user_shell = 0;

    pid_t cur = pid;
    for (int i = 0; i < MAX_CHAIN; i++) {
        int u = -1, pp = -1;
        if (read_status(cur, &u, &pp) != 0) {
            break;
        }
        chain[depth] = cur;
        uid[depth] = u;
        comm[depth][0] = 0;
        read_comm(cur, comm[depth], sizeof(comm[depth]));
        if (strcmp(comm[depth], "adbd") == 0) {
            user_shell = 1;
            break;
        }
        depth++;
        if (pp <= 1 || pp == cur) {
            break;
        }
        cur = (pid_t) pp;
    }

    if (user_shell) {
        sk_event("guard: 用户 adb shell 的 force-stop, 放行 pid=%d", (int) pid);
        return 0;
    }

    /* 1) 先掐 am 本体。
     *
     * 这台设备内核没有 Yama,实测同 uid 兄弟进程可以 PTRACE_ATTACH 成功
     * (探针输出 ATTACH=0, waitpid 看到 SIGSTOP)。ATTACH 会让目标立刻停住,
     * 内核保证它不可能再往下发 Binder —— 于是"kill 信号还没送到、
     * AMS 已经被调完"的竞态被消掉,变成确定性拦截。
     *
     * 附加失败(目标刚好退出 / 换了 ROM 权限收紧)时退回原来的裸 kill,
     * 不会因为 ptrace 不可用反而放跑攻击者。
     */
    int pst = 0;
    if (ptrace(PTRACE_ATTACH, pid, NULL, NULL) == 0) {
        waitpid(pid, &pst, 0);          // 等它真的进 ptrace-stop
        sk_event("guard: ptrace 冻住 pid=%d", (int) pid);
        if (kill(pid, SIGKILL) != 0) {
            sk_event("guard: 冻住后 kill 失败 pid=%d errno=%d", (int) pid, errno);
        }
        waitpid(pid, &pst, 0);          // 回收,别留僵尸
    } else if (kill(pid, SIGKILL) != 0) {
        sk_event("guard: 掐 am 失败 pid=%d errno=%d", (int) pid, errno);
    }

    /* 2) 反杀: 链上 uid 2000 且非自己人的常驻件 */
    char detail[400];
    int off = snprintf(detail, sizeof(detail), "pid=%d target=%s", (int) pid, SK_PKG);
    for (int i = 1; i < depth && off > 0 && off < (int) sizeof(detail) - 80; i++) {
        char acmd[400] = {0};
        sk_cmdline(chain[i], acmd, sizeof(acmd));
        if (acmd[0] == 0) {
            continue;
        }
        if (strstr(acmd, ".sk/") || strstr(acmd, "sk_guard")) {
            continue;
        }
        off += snprintf(detail + off, sizeof(detail) - (size_t) off,
                        " <= %s(%d)", comm[i], (int) chain[i]);
        if (uid[i] == 2000) {
            if (kill(chain[i], SIGKILL) == 0) {
                off += snprintf(detail + off, sizeof(detail) - (size_t) off,
                                "[已反杀]");
            }
        }
    }

    /*
     * 3) 解析凶手包名，把 force-stop 原样打回去。
     *    先看祖先 cmdline；cmdline 里没有路径时，再读 /proc/<pid>/cwd、
     *    exe、environ、maps —— daemon 化的守护通常只剩一个 sh，包名藏在
     *    工作目录或环境变量里。绝不指向自己。
     */
    for (int i = 0; i < depth; i++) {
        char acmd[400] = {0};
        char pkg[128];
        int got = -1;
        if (sk_cmdline(chain[i], acmd, sizeof(acmd)) > 0) {
            got = pkg_from_cmd(acmd, pkg, sizeof(pkg));
        }
        if (got != 0) {
            got = pkg_from_proc(chain[i], pkg, sizeof(pkg));
        }
        if (got == 0 && strcmp(pkg, SK_PKG) != 0) {
            char c[256];
            snprintf(c, sizeof(c), "am force-stop %s >/dev/null 2>&1", pkg);
            sk_run(c, NULL, 0);
            sk_event("guard: 对焦回击 %s", pkg);
            break;
        }
    }

    note_block("guard: 拦截攻击", detail);
    return 1;
}

/* 扫一遍新出现的进程, 并对最近出现的进程做短时重检 */
static int scan_once(void)
{
    memset(g_cur, 0, sizeof(g_cur));
    DIR *d = opendir("/proc");
    if (!d) {
        return 0;
    }
    struct dirent *de;
    pid_t self = getpid();

    while ((de = readdir(d)) != NULL) {
        if (!isdigit((unsigned char) de->d_name[0])) {
            continue;
        }
        pid_t pid = (pid_t) atoi(de->d_name);
        if (pid <= 1) {
            continue;
        }
        bit_set(g_cur, pid);
        if (bit_get(g_seen, pid) || pid == self) {
            continue;
        }
        pend_add(pid);                      /* 刚出现, 进重检队列 */
    }
    closedir(d);
    memcpy(g_seen, g_cur, sizeof(g_seen));

    int hit = 0;
    for (int i = 0; i < g_pend_n; ) {
        pid_t pid = g_pend[i].pid;
        char cmd[512];
        if (sk_cmdline(pid, cmd, sizeof(cmd)) > 0
                && is_attack_cmd(cmd)) {
            if (handle_hit(pid, cmd)) {
                hit++;
            }
            pend_remove(i);
            continue;
        }
        if (--g_pend[i].left <= 0) {
            pend_remove(i);
            continue;
        }
        i++;
    }
    return hit;
}

int sk_main(int argc, char **argv)
{
    char apk[512] = {0};
    if (argc > 0 && argv[0]) {
        snprintf(apk, sizeof(apk), "%s", argv[0]);
    }
    prctl(PR_SET_NAME, "sk_guard", 0, 0, 0);
    signal(SIGPIPE, SIG_IGN);
    signal(SIGHUP, SIG_IGN);

    sk_pidfile("guard", getpid());
    char buf[32];
    if (sk_read_file(SK_STATE "/blocked", buf, sizeof(buf)) > 0) {
        g_blocked = atoi(buf);
    }
    sk_event("guard: 启动 uid=%d 扫描间隔=%dms 重检=%dms", (int) getuid(),
             GUARD_INTERVAL_US / 1000, PEND_ROUNDS * GUARD_INTERVAL_US / 1000);

    int beat = 0;
    int peer = 0;
    int diag = 0;
    long long max_ms = 0;
    for (;;) {
        if (sk_stop_requested()) {
            sk_event("guard: 收到紧急退出标记, 停止");
            break;
        }
        long long t0 = sk_now_ms();
        scan_once();
        long long dt = sk_now_ms() - t0;
        if (dt > max_ms) {
            max_ms = dt;
        }
        (void) peer;

        if (++beat >= 100) {                 /* ~1 秒一次心跳 */
            beat = 0;
            sk_heartbeat("guard");
        }
        /*
         * 这里刻意不做"拉起兄弟"的动作: sk_spawn 要解 zip、fork、写 16KB、waitpid,
         * 会把扫描循环卡住几十毫秒 —— 实测就在这个窗口里输过一次竞态。
         * 兄弟的存活交给 sk_sweep / sk_revive 负责, guard 只管一件事: 扫得快。
         */
        if (++diag >= 1000) {               /* ~10 秒报一次最坏扫描耗时 */
            diag = 0;
            if (max_ms > 12) {
                sk_event("guard: 扫描最坏耗时 %lldms", (long long) max_ms);
            }
            max_ms = 0;
        }
        usleep(GUARD_INTERVAL_US);
    }
    unlink(SK_STATE "/guard.pid");
    return 0;
}
