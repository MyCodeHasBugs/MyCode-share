/*
 * sk_sweep —— 持续清理"别人的 shell 守护"
 *
 * 目标画像(四条同时满足):
 *   1. uid == 2000(shell) —— 免 root 工具都是用 adb shell 起常驻进程;
 *   2. ppid == 1     —— 已经 daemon 化, 不是谁的前台会话;
 *   3. 命令行里带 /data 或 /sdcard —— 排掉系统分区里的控制台 sh 与 adbd;
 *   4. 不是我们自己  —— .sk/ 下的 boot / sk_sweep / sk_revive。
 *
 * 为什么不一刀切"uid 2000 全杀":
 *   实测同机里 uid 2000 还混着 /system/bin/sh(init 的控制台) 和
 *   /apex/com.android.adbd/bin/adbd —— 后者是 adb 的命脉, 杀了直接断线。
 *   判据必须细到"这个进程是不是别人部署的用户态脚本/二进制"。
 *
 * 每轮最多清 2 个: 用户要的是"逐个击破", 不是瞬间团灭; 慢一点也更容易
 * 从日志里看清发生了什么。
 */
#include "sk_common.h"

#define SWEEP_INTERVAL_MS 1000
#define MAX_KILL_PER_ROUND 8      /* 用户反馈'对方总能复活': 一轮多清几个, 扫得也更勤 */

static int g_hits = 0;

static const char *sk_basename(const char *path)
{
    const char *slash = strrchr(path, '/');
    return slash ? slash + 1 : path;
}

/* 瞬时工具: 就算被 daemon 化也不碰, 免得砍到自己的执行链 */
static int is_transient_tool(const char *cmd)
{
    static const char *const names[] = {
            "am", "pm", "cmd", "dumpsys", "settings", "getprop", "setprop",
            "logcat", "id", "date", "cat", "ls", "toybox", "sh", NULL
    };
    char first[128];
    int i = 0;
    while (cmd[i] && cmd[i] != ' ' && i < (int) sizeof(first) - 1) {
        first[i] = cmd[i];
        i++;
    }
    first[i] = 0;
    const char *base = sk_basename(first);

    /* 解释器本身不算工具: sh 后面跟的是脚本, 脚本路径才是判据 */
    for (int k = 0; names[k]; k++) {
        if (strcmp(base, names[k]) == 0) {
            return strcmp(base, "sh") != 0;
        }
    }
    return 0;
}

/* 循环型守护的特征: 没有脚本路径, 但命令行里带 while/sleep */
static int looks_like_loop(const char *cmd)
{
    return strstr(cmd, "while ") != NULL || strstr(cmd, "until ") != NULL
           || strstr(cmd, "sleep ") != NULL;
}

static void note_hit(pid_t pid, const char *cmd)
{
    g_hits++;
    char num[32];
    snprintf(num, sizeof(num), "%d", g_hits);
    sk_write_str(SK_STATE "/hits", num);
    sk_write_str(SK_STATE "/last", cmd);

    size_t n = strlen(cmd);
    if (n > 160) {
        n = 160;
    }
    char shortcmd[168];
    memcpy(shortcmd, cmd, n);
    shortcmd[n] = 0;
    sk_event("清掉 pid=%d %s", (int) pid, shortcmd);
}


/* ---------------------------------------------------- 守护树 / 包名解析 */

static int comm_is(pid_t pid, const char *name)
{
    char path[64], buf[48];
    snprintf(path, sizeof(path), "/proc/%d/comm", (int) pid);
    if (sk_read_file(path, buf, sizeof(buf)) <= 0) {
        return 0;
    }
    char *nl = strchr(buf, '\n');
    if (nl) {
        *nl = 0;
    }
    return strcmp(buf, name) == 0;
}

/*
 * 只看 ppid==1 会漏掉一大类: 守护进程被一层 sh 包着启动
 * (sh -c "while ...; do ...; done"), 真正的目标挂在它下面, ppid != 1。
 * 这里往上找最多 4 层。
 *
 * 返回:
 *   ANC_DAEMON —— 链上有 uid 2000 / ppid 1 的常驻祖先, 标准"别人的守护树";
 *   ANC_ADBD   —— 链上出现 adbd: 这是从 adb 会话里跑出来的东西。
 *                 以前这里直接返回 0(放行), 结果对手用 `adb shell` 起的
 *                 守护全漏了; 现在我们把它也当守护树, 只额外要求"活过 3 秒"
 *                 来排掉一次性命令。
 *
 * 自己的载荷(cmdline 带 .sk/)在调用处已经排掉, 不会走到这里。
 */
#define ANC_NONE   0
#define ANC_DAEMON 1
#define ANC_ADBD   2

static int has_daemon_ancestor(pid_t pid, int depth)
{
    pid_t cur = pid;
    for (int i = 0; i < depth; i++) {
        int uid = -1, ppid = -1;
        if (sk_proc_status(cur, &uid, &ppid, NULL) != 0) {
            return ANC_NONE;
        }
        if (comm_is(cur, "adbd")) {
            return ANC_ADBD;
        }
        if (ppid <= 1) {
            return (uid == 2000 && ppid == 1) ? ANC_DAEMON : ANC_NONE;
        }
        cur = (pid_t) ppid;
        if (cur <= 1) {
            return ANC_NONE;
        }
        int au = -1, ap = -1;
        if (sk_proc_status(cur, &au, &ap, NULL) != 0) {
            return ANC_NONE;
        }
        if (comm_is(cur, "adbd")) {
            return ANC_ADBD;
        }
        if (au == 2000 && ap == 1) {
            return ANC_DAEMON;
        }
    }
    return ANC_NONE;
}

/* uid -> 包名, 用 pm list packages -U 建一次缓存, 10 分钟刷新 */
#define PKG_MAX 500
static char g_pkg[PKG_MAX][96];
static int g_pkg_uid[PKG_MAX];
static int g_pkg_n;
static long long g_pkg_ts;

static void load_pkgs(void)
{
    long long now = sk_now_ms();
    if (g_pkg_n > 0 && now - g_pkg_ts < 600000) {
        return;
    }
    g_pkg_n = 0;
    g_pkg_ts = now;
    FILE *fp = popen("pm list packages -U 2>/dev/null", "r");
    if (!fp) {
        return;
    }
    char line[256];
    while (fgets(line, sizeof(line), fp) != NULL && g_pkg_n < PKG_MAX) {
        char *p = strstr(line, "package:");
        char *u = strstr(line, "uid:");
        if (!p || !u) {
            continue;
        }
        p += 8;
        char *end = u - 1;
        while (end > p && (*end == ' ' || *end == '\t')) {
            end--;
        }
        size_t len = (size_t) (end - p + 1);
        if (len == 0 || len >= sizeof(g_pkg[0])) {
            continue;
        }
        memcpy(g_pkg[g_pkg_n], p, len);
        g_pkg[g_pkg_n][len] = 0;
        g_pkg_uid[g_pkg_n] = atoi(u + 4);
        g_pkg_n++;
    }
    pclose(fp);
    sk_event("sweep: 包名表 %d 条", g_pkg_n);
}

static int pkg_for_uid(int uid, char *out, size_t sz)
{
    load_pkgs();
    for (int i = 0; i < g_pkg_n; i++) {
        if (g_pkg_uid[i] == uid) {
            snprintf(out, sz, "%s", g_pkg[i]);
            return i;
        }
    }
    return -1;
}

/* 每个包被清掉的次数: 反复复活的就升级处置 */
static int g_pkg_kills[PKG_MAX];
static long long g_pkg_last_hit[PKG_MAX];

/* 逃生开关: 只 force-stop, 不做"禁用应用"的升级处置 */
static int rival_disable_disabled(void)
{
    return access(SK_STATE "/no_rival_disable", F_OK) == 0;
}

/* ------------------------------------------------ 自身防卸载 / 防禁用 */

/* 把正在运行的 APK 备份两份: 一份明名, 一份不带扩展名(少一眼看穿) */
#define SK_APK2 "/data/local/tmp/.adbk"   /* 不同目录: 删 .sk 也删不掉它 */

static int file_ok(const char *path)
{
    struct stat st;
    return stat(path, &st) == 0 && st.st_size > 100000;
}

static void backup_apk(void)
{
    int a = file_ok(SK_APK);
    int b = file_ok(SK_APK2);
    if (a && b) {
        return;                         /* 两份都在 */
    }
    char out[512] = {0};
    FILE *fp = popen("pm path " SK_PKG " 2>/dev/null", "r");
    if (!fp) {
        return;
    }
    size_t n = fread(out, 1, sizeof(out) - 1, fp);
    out[n] = 0;
    pclose(fp);
    char *p = strstr(out, "package:");
    if (!p) {
        return;
    }
    p += 8;
    char *nl = strchr(p, '\n');
    if (nl) {
        *nl = 0;
    }
    char c[1024];
    if (!a) {
        snprintf(c, sizeof(c),
                 "cp -f %s %s >/dev/null 2>&1; chmod 644 %s >/dev/null 2>&1",
                 p, SK_APK, SK_APK);
        sk_run(c, NULL, 0);
    }
    if (!b) {
        snprintf(c, sizeof(c),
                 "cp -f %s %s >/dev/null 2>&1; chmod 644 %s >/dev/null 2>&1",
                 p, SK_APK2, SK_APK2);
        sk_run(c, NULL, 0);
    }
    if (file_ok(SK_APK) || file_ok(SK_APK2)) {
        struct stat st;
        stat(file_ok(SK_APK) ? SK_APK : SK_APK2, &st);
        sk_event("sweep: 已备份 APK %lld KB", (long long) (st.st_size / 1024));
    } else {
        sk_event("sweep: APK 备份失败(源 %s)", p);
    }
}

/* 包是否被 disable-user 了(pm list packages -d) */
static int pkg_disabled(void)
{
    char out[8192] = {0};
    FILE *fp = popen("pm list packages -d 2>/dev/null", "r");
    if (!fp) {
        return 0;
    }
    size_t n = fread(out, 1, sizeof(out) - 1, fp);
    out[n] = 0;
    pclose(fp);
    return strstr(out, SK_PKG) != NULL;
}

/**
 * 自身存活检查: 被卸载就装回来, 被禁用就启用回来。
 *
 * 别的应用拿到 shell 后除了 force-stop 还能干两件更狠的:
 *   pm uninstall com.sk.keeper   —— APK 没了, 一切归零
 *   pm disable-user com.sk.keeper —— 包还在但不可启动, 等同消失
 * 这里两道都兜: 有备份就 pm install -r -g, 被禁用就 pm enable。
 * 设备管理器(Java 侧)会先拦 uninstall; 这一层是它失效时的后手。
 */
static void self_heal(void)
{
    if (!sk_pkg_installed()) {
        const char *bak = file_ok(SK_APK) ? SK_APK
                        : (file_ok(SK_APK2) ? SK_APK2 : NULL);
        if (bak == NULL) {
            sk_event("sweep: App 被卸载且两份备份都没了, 无法恢复");
            return;
        }
        sk_event("sweep: App 被卸载, 从备份重装 (%s)", bak);
        char c[768];
        snprintf(c, sizeof(c), "pm install -r -g %s >/dev/null 2>&1", bak);
        sk_run(c, NULL, 0);
        sk_run("am start -n " SK_ACT " --ez sk_revive true >/dev/null 2>&1", NULL, 0);
        /* 装回来了就把缺的那份备份补上 */
        backup_apk();
        return;
    }
    if (pkg_disabled()) {
        sk_event("sweep: App 被禁用, 重新启用");
        sk_run("pm enable --user 0 " SK_PKG " >/dev/null 2>&1", NULL, 0);
        sk_run("am start -n " SK_ACT " --ez sk_revive true >/dev/null 2>&1", NULL, 0);
    }
}

/*
 * 处置一个"在用 adb 的第三方应用"。
 *
 * 递进(真机反馈"他们总能复活", 所以不能只 force-stop):
 *   0. kill(pid, SIGKILL)   先把眼前这个进程按死, force-stop 是异步的
 *   1. am force-stop        杀掉整个 uid
 *   2. appops ignore        禁止后台执行, 掐掉 JobScheduler/广播自启
 *      standby-bucket restricted / 撤电池白名单   —— 让它更早被系统回收
 *   3. 第 2 次复活 -> pm disable-user   直接禁用(桌面图标还在, 可 pm enable 恢复)
 *   4. 第 3 次复活(说明有人把它 enable 回来了) -> pm clear, 连配对过的
 *      密钥/端点一起清掉。这是"清掉对手无线调试"最彻底的一层:
 *      它再被拉起来也没有授权 key, 必须让用户重新配对才能用 adb。
 *
 * 逃生开关: SK_STATE/no_rival_disable 只停在第 1~2 档;
 *           SK_STATE/no_rival_clear 额外禁止第 4 档 pm clear。
 */
static int rival_clear_disabled(void)
{
    return access(SK_STATE "/no_rival_clear", F_OK) == 0;
}

static void hard_stop_pkg(pid_t pid, int idx, const char *pkg, int uid, const char *cmd)
{
    char c[320];

    /* 0) 先按死当前进程: force-stop 要走 AMS, 中间还有几十毫秒 */
    kill(pid, SIGKILL);

    snprintf(c, sizeof(c), "am force-stop %s >/dev/null 2>&1", pkg);
    sk_run(c, NULL, 0);

    /* 两个名字都发: 不同 API 版本认不同的 key */
    snprintf(c, sizeof(c), "cmd appops set %s RUN_ANY_IN_BACKGROUND ignore "
                           ">/dev/null 2>&1", pkg);
    sk_run(c, NULL, 0);
    snprintf(c, sizeof(c), "cmd appops set %s RUN_IN_BACKGROUND ignore "
                           ">/dev/null 2>&1", pkg);
    sk_run(c, NULL, 0);

    /* 限制待机桶 + 撤掉电池白名单: 双保险, 让它更难被 JobScheduler 拉活 */
    snprintf(c, sizeof(c), "am set-standby-bucket %s restricted >/dev/null 2>&1", pkg);
    sk_run(c, NULL, 0);
    snprintf(c, sizeof(c), "cmd deviceidle whitelist -%s >/dev/null 2>&1", pkg);
    sk_run(c, NULL, 0);

    int n = 0;
    if (idx >= 0 && idx < PKG_MAX) {
        /*
         * 只在"隔了 5 秒以上又出现"时才计数: 同一个包被杀瞬间还会留下
         * 几个同 uid 的进程, 同轮/紧邻命中不能算"复活", 否则计数瞬间到 3
         * 就会把普通工具误禁用。
         */
        long long now = sk_now_ms();
        if (now - g_pkg_last_hit[idx] > 5000) {
            n = ++g_pkg_kills[idx];
            g_pkg_last_hit[idx] = now;
        } else {
            n = g_pkg_kills[idx];
        }
    }

    char detail[220];
    if (n >= 3 && !rival_disable_disabled()) {
        if (!rival_clear_disabled()) {
            /* 连数据一起清: 配对 key / 保存的端点 / 自启配置全部归零 */
            snprintf(c, sizeof(c), "pm clear %s >/dev/null 2>&1", pkg);
            sk_run(c, NULL, 0);
            snprintf(detail, sizeof(detail),
                     "app %s (uid=%d) 第 %d 次复活 -> 已清数据+禁用  [%s]",
                     pkg, uid, n, cmd);
        } else {
            snprintf(detail, sizeof(detail),
                     "app %s (uid=%d) 第 %d 次复活 -> 已禁用  [%s]", pkg, uid, n, cmd);
        }
        snprintf(c, sizeof(c), "pm disable-user --user 0 %s >/dev/null 2>&1", pkg);
        sk_run(c, NULL, 0);
    } else if (n >= 2 && !rival_disable_disabled()) {
        snprintf(c, sizeof(c), "pm disable-user --user 0 %s >/dev/null 2>&1", pkg);
        sk_run(c, NULL, 0);
        snprintf(detail, sizeof(detail),
                 "app %s (uid=%d) 第 %d 次复活 -> 已禁用  [%s]", pkg, uid, n, cmd);
    } else {
        snprintf(detail, sizeof(detail),
                 "app %s (uid=%d) 已停+禁后台 第 %d 次  [%s]", pkg, uid, n, cmd);
    }
    note_hit(pid, detail);
}

/* App 里的 shell 守护: /system/bin/sh 脚本 或 app_process 起的守护 */
static int looks_like_app_daemon(const char *cmd)
{
    if (strstr(cmd, "/system/bin/sh ") == cmd || strncmp(cmd, "sh ", 3) == 0) {
        return 1;
    }
    if (strstr(cmd, "app_process") != NULL) {
        return 1;
    }
    return 0;
}

/*
 * App 直接 fork 出来的 shell 守护(ppid 是 App 本身, 不是 1)。
 * 这类东西上一版完全漏掉 —— 对手把常驻脚本挂在应用进程下面, 我们只清
 * ppid==1 的, 看起来就是"怎么杀都杀不干净"。
 *
 * 判据收紧到"不是一次性命令"且有脚本/循环特征, 再加 5 秒存活门槛:
 * App 正常调用 sh 都是毫秒级结束, 活过 5 秒的才有资格被当成守护。
 */
static int looks_like_shell_daemon(const char *cmd)
{
    if (strncmp(cmd, "/system/bin/sh ", 14) != 0 && strncmp(cmd, "sh ", 3) != 0) {
        return 0;
    }
    if (strstr(cmd, "-c") != NULL) {
        return 0;
    }
    return strstr(cmd, ".sh") != NULL || strstr(cmd, "while") != NULL
           || strstr(cmd, "sleep") != NULL;
}

/*
 * 别的 ADB 工具跑起来的客户端/服务端进程。
 *
 * 这类进程的父进程就是那个 App 本身(ppid 不是 1), 上一版只清
 * "ppid==1 的 shell 守护", 完全漏掉它们 —— 表现就是"杀了又活"。
 * 命中特征(任一):
 *   libadbcli.so / libadb.so      把 adb 二进制改名成 so 放进 lib 目录(和我们一样)
 *   /adb 结尾或后跟空格           以可执行文件形态跑
 *   adb server / adb_server       显式起的 server
 *   adbkey / adb_keys             配对的客户端
 */
static int looks_like_adb_tool(const char *cmd)
{
    if (strstr(cmd, "libadb") != NULL) {
        return 1;
    }
    if (strstr(cmd, "adb server") != NULL || strstr(cmd, "adb_server") != NULL) {
        return 1;
    }
    if (strstr(cmd, "adbkey") != NULL || strstr(cmd, "adb_keys") != NULL) {
        return 1;
    }
    /* "/adb" 作为独立 token: 前面是 /, 后面是空格或字符串结束 */
    const char *p = cmd;
    while ((p = strstr(p, "/adb")) != NULL) {
        char n = p[4];
        if (n == 0 || n == ' ' || n == '\t') {
            return 1;
        }
        p += 4;
    }
    return 0;
}


/* ------------------------------------------------ adbd 上的外来会话 */

/* 进程存活秒数: /proc/uptime 减去 starttime(jiffies) */
static int proc_age_sec(pid_t pid)
{
    char path[64];
    snprintf(path, sizeof(path), "/proc/%d/stat", (int) pid);
    FILE *fp = fopen(path, "r");
    if (!fp) {
        return 0;
    }
    char buf[1024];
    size_t n = fread(buf, 1, sizeof(buf) - 1, fp);
    fclose(fp);
    if (n == 0) {
        return 0;
    }
    buf[n] = 0;
    char *p = strrchr(buf, ')');            /* comm 里可能有空格和括号 */
    if (!p) {
        return 0;
    }
    int field = 3;                          /* ')' 之后第一个是 state */
    char *tok = strtok(p + 1, " ");
    while (tok) {
        if (field == 22) {                  /* starttime */
            unsigned long long start = strtoull(tok, NULL, 10);
            double up = 0;
            FILE *uf = fopen("/proc/uptime", "r");
            if (uf) {
                if (fscanf(uf, "%lf", &up) != 1) {
                    up = 0;
                }
                fclose(uf);
            }
            long hz = sysconf(_SC_CLK_TCK);
            if (hz <= 0) {
                hz = 100;
            }
            double age = up - (double) start / (double) hz;
            return age > 0 ? (int) age : 0;
        }
        field++;
        tok = strtok(NULL, " ");
    }
    return 0;
}

/* 逃生开关: 有这个文件就不动别人的 adb 会话 / tcpip 端口 */
static int adb_kick_disabled(void)
{
    return access(SK_STATE "/no_adb_kick", F_OK) == 0;
}

/* 别人可能用 `adb tcpip 5555` 绕过无线调试的开关, 这里把它复位 */
static void reset_tcpip_port(void)
{
    char v[64] = {0};
    FILE *fp = popen("getprop service.adb.tcp.port 2>/dev/null", "r");
    if (!fp) {
        return;
    }
    if (fgets(v, sizeof(v), fp) == NULL) {
        v[0] = 0;
    }
    pclose(fp);
    int port = atoi(v);
    if (port <= 0) {
        return;
    }
    sk_event("sweep: 发现 adb tcpip 端口 %d, 复位", port);
    sk_run("setprop service.adb.tcp.port -1", NULL, 0);
    sk_run("setprop persist.adb.tcp.port -1", NULL, 0);
}

static int sweep_once(void)
{
    DIR *d = opendir("/proc");
    if (!d) {
        return 0;
    }
    int killed = 0;
    pid_t self = getpid();
    pid_t adbd = adb_kick_disabled() ? -1 : sk_pid_by_comm("adbd");
    struct dirent *de;

    while ((de = readdir(d)) != NULL && killed < MAX_KILL_PER_ROUND) {
        if (!isdigit((unsigned char) de->d_name[0])) {
            continue;
        }
        pid_t pid = (pid_t) atoi(de->d_name);
        if (pid <= 1 || pid == self) {
            continue;
        }
        int uid = -1, ppid = -1;
        char state = '?';
        if (sk_proc_status(pid, &uid, &ppid, &state) != 0) {
            continue;
        }
        if (state == 'Z') {
            continue;
        }
        char cmd[512];
        if (sk_cmdline(pid, cmd, sizeof(cmd)) <= 0) {
            continue;
        }
        if (strstr(cmd, ".sk/") || strstr(cmd, "sk_sweep") || strstr(cmd, "sk_revive")
                || strstr(cmd, "sk_guard")) {
            continue;                       /* 自己人 */
        }
        if (strstr(cmd, "adbd") != NULL) {
            continue;                       /* adb 命脉 */
        }

        if (uid == 2000) {
            /*
             * ---- C. adbd 下的外来会话(无线调试连进来的) ----
             * 不再只认 sh/bash: 对手完全可以把自定义 ELF 丢到 /data 里,
             * 由 `adb shell` 直接拉起来常驻。一次性命令(sh -c / *.sh)
             * 交给 A 分支按路径判断, 这里只处理"活过 2 秒"的常驻件。
             */
            int one_shot = strstr(cmd, "-c") != NULL || strstr(cmd, ".sh") != NULL;
            if (adbd > 0 && ppid == adbd && !one_shot) {
                /*
                 * abb 是 adbd 的 binder 桥, `am`/`pm`/`cmd` 都靠它进系统;
                 * 杀它等于把自己的执行链一起砍了 —— 唯一不能碰的 adbd 子进程。
                 */
                if (comm_is(pid, "abb") || strncmp(cmd, "abb", 3) == 0) {
                    continue;
                }
                if (proc_age_sec(pid) >= 2 && kill(pid, SIGKILL) == 0) {
                    char detail[200];
                    snprintf(detail, sizeof(detail), "adb 会话 %s", cmd);
                    note_hit(pid, detail);
                    killed++;
                }
                continue;                   /* 常驻会话到此为止, 不再走 A */
            }

            /*
             * ---- D. 伪装成"一次性命令"的常驻循环 ----
             * 对手最常见的写法就是 `adb shell "sh -c 'while true; do ...; done'"`,
             * 命令行带 -c, C 分支会当成一次性命令放过; 但它活过 8 秒就说明
             * 是个循环。我们自己的 sh -c 最长也就 2~3 秒(部署/紧急退出),
             * 8 秒门槛不会误伤。
             */
            if (adbd > 0 && ppid == adbd && one_shot && proc_age_sec(pid) >= 8) {
                if (kill(pid, SIGKILL) == 0) {
                    char detail[200];
                    snprintf(detail, sizeof(detail), "长驻命令 %s", cmd);
                    note_hit(pid, detail);
                    killed++;
                }
                continue;
            }

            /*
             * ---- A. 别人的 shell 守护(含被 sh 包着的守护树) ----
             * has_daemon_ancestor 现在也会返回 ANC_ADBD: 对手用 adb shell
             * 起的守护, 父链一定经过 adbd, 以前被当成"用户会话"放过了。
             * 3 秒门槛用来排掉 `sh -c` 一次性命令。
             */
            int anc = has_daemon_ancestor(pid, 4);
            if (ppid != 1 && anc == ANC_NONE) {
                continue;
            }
            if (anc == ANC_ADBD && proc_age_sec(pid) < 3) {
                continue;
            }
            if (strstr(cmd, "/data/") == NULL && strstr(cmd, "/sdcard/") == NULL) {
                /*
                 * 没有路径的常驻件也有一大类: 对手直接
                 * `adb shell "while true; do am start ...; sleep 5; done"`。
                 * 这种命令行里没有 /data, 老判据会整条放过。这里补一条:
                 * 带循环特征 + 活过 8 秒, 才当目标。
                 */
                if (proc_age_sec(pid) < 8 || !looks_like_loop(cmd)) {
                    continue;
                }
            }
            if (is_transient_tool(cmd)) {
                continue;
            }
            if (kill(pid, SIGKILL) == 0) {
                note_hit(pid, cmd);
                killed++;
            }
        } else if (uid >= 10000) {
            /*
             * ---- B. 第三方 App 的 shell 守护 / adb 工具 ----
             * 老版本要求 ppid==1 且是 sh/app_process, 漏掉了三大类:
             *   · App fork 出来的 adb 客户端(ppid 是 App 本身)
             *   · 用 libadb*.so 形态跑的 adb server
             *   · App 直接挂在 ppid 下的常驻 sh 脚本
             * 它们被杀后会被自己的前台服务/JobScheduler 拉回来 ——
             * 所以这里改成"识别 + 递进处置"。
             */
            int hit = 0;
            if (ppid == 1 && looks_like_app_daemon(cmd)) {
                hit = 1;
            } else if (looks_like_adb_tool(cmd)) {
                hit = 1;
            } else if (looks_like_shell_daemon(cmd) && proc_age_sec(pid) >= 5) {
                hit = 1;
            }
            if (!hit) {
                continue;
            }
            char pkg[128];
            int idx = pkg_for_uid(uid, pkg, sizeof(pkg));
            if (idx < 0) {
                continue;
            }
            if (strcmp(pkg, "com.sk.keeper") == 0) {
                continue;                   /* 永远不指向自己 */
            }
            hard_stop_pkg(pid, idx, pkg, uid, cmd);
            killed++;
        }
    }
    closedir(d);
    return killed;
}

int sk_main(int argc, char **argv)
{
    char apk[512] = {0};
    if (argc > 0 && argv[0]) {
        snprintf(apk, sizeof(apk), "%s", argv[0]);
    }
    prctl(PR_SET_NAME, "sk_sweep", 0, 0, 0);
    signal(SIGPIPE, SIG_IGN);
    signal(SIGHUP, SIG_IGN);

    sk_pidfile("sweep", getpid());

    char buf[32];
    if (sk_read_file(SK_STATE "/hits", buf, sizeof(buf)) > 0) {
        g_hits = atoi(buf);
    }
    sk_event("sweep: 启动 uid=%d apk=%s", (int) getuid(), apk);

    /* 先把包名表建好: pm list 要 1~2 秒, 别等第一次命中时才卡一下 */
    load_pkgs();

    /* 备份自身 APK: 被 pm uninstall 之后靠它装回来 */
    backup_apk();

    int tick = 0;

    for (;;) {
        if (sk_stop_requested()) {
            sk_event("sweep: 收到紧急退出标记, 停止");
            break;
        }
        sk_heartbeat("sweep");

        sweep_once();
        tick++;

        /*
         * 每 3 秒复位一次 tcpip 端口: 对手常用 `adb tcpip 5555` 绕过无线
         * 调试开关, 把 adbd 直接挂到固定端口上。这条很便宜(getprop), 勤查。
         */
        if (tick % 3 == 0 && !adb_kick_disabled()) {
            reset_tcpip_port();
        }

        /*
         * 每 10 秒确认 App 还装着。以前这里是"App 被卸载就自己退出" ——
         * 那等于认输。现在改成自愈: 从备份重装 / 重新启用, 不退出。
         * 10 秒一次是权衡: pm path 要起一次 app_process(几百毫秒), 太勤
         * 会白耗电; 太慢则被卸载后很久才发现。
         */
        if (tick % 10 == 0) {
            self_heal();
            backup_apk();
        }

        /* 每 6 秒确认兄弟还活着 */
        if (tick % 6 == 0 && apk[0]) {
            sk_ensure_peer(apk, "sk_revive", 12);
            sk_ensure_peer(apk, "sk_guard", 12);
        }
        usleep(SWEEP_INTERVAL_MS * 1000);
    }

    unlink(SK_STATE "/sweep.pid");
    return 0;
}
