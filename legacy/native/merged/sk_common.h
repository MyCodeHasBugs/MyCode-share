/*
 * Keeper 载荷公共层
 *
 * 运行形态: 由 sk_boot 从 memfd 匿名内存加载, dlopen 后调用 sk_main()。
 * 进程身份: 继承 adb shell 的 uid 2000(shell), 已 setsid 脱离 App 的 cgroup。
 *
 * 这里只做四件事:
 *   1. 路径/写文件/心跳, 让两个载荷能看见对方还活着;
 *   2. /proc 扫描, 判断某个 pid 是不是"别人的 shell 守护";
 *   3. 从自己的 APK 里取出 payload ELF, 重启兄弟进程(不落盘);
 *   4. 接上 logcat, 方便排查。
 */
#ifndef SK_COMMON_H
#define SK_COMMON_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <ctype.h>
#include <time.h>
#include <dirent.h>
#include <signal.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/prctl.h>
#include <android/log.h>

#define SK_TAG    "Skeeper"
#define SK_DIR    "/data/local/tmp/.sk"
#define SK_STATE  "/data/local/tmp/.sk/state"
#define SK_BOOT   "/data/local/tmp/.sk/boot"
/** 运行中的 APK 备份: 包被 pm uninstall 之后靠它装回来 */
#define SK_APK    "/data/local/tmp/.sk/keeper.apk"
#define SK_LOG    "/data/local/tmp/.sk/state/log"
#define SK_PKG    "com.sk.keeper"
#define SK_ACT    "com.sk.keeper/.MainActivity"

/* 紧急退出标记: App 用 MediaStore 写, shell 侧只读。
 * 两条路径都查, 覆盖 /sdcard 软链不可用的环境。 */
#define SK_STOP1  "/sdcard/Download/Keeper/keeper.stop"
#define SK_STOP2  "/storage/emulated/0/Download/Keeper/keeper.stop"

/* ------------------------------------------------------------------ 基础 */

static long long sk_now_ms(void)
{
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (long long) ts.tv_sec * 1000LL + ts.tv_nsec / 1000000LL;
}

static long long sk_wall_s(void)
{
    return (long long) time(NULL);
}

static int sk_write_file(const char *path, const void *data, size_t len)
{
    int fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd < 0) {
        return -1;
    }
    const char *p = (const char *) data;
    size_t off = 0;
    while (off < len) {
        ssize_t n = write(fd, p + off, len - off);
        if (n <= 0) {
            close(fd);
            return -1;
        }
        off += (size_t) n;
    }
    close(fd);
    return 0;
}

static int sk_write_str(const char *path, const char *s)
{
    return sk_write_file(path, s, strlen(s));
}

static int sk_read_file(const char *path, char *buf, size_t sz)
{
    int fd = open(path, O_RDONLY);
    if (fd < 0) {
        return -1;
    }
    ssize_t n = read(fd, buf, sz - 1);
    close(fd);
    if (n < 0) {
        return -1;
    }
    buf[n] = 0;
    return (int) n;
}

static void sk_log(const char *fmt, ...)
{
    char buf[512];
    va_list ap;
    va_start(ap, fmt);
    vsnprintf(buf, sizeof(buf), fmt, ap);
    va_end(ap);
    __android_log_print(ANDROID_LOG_INFO, SK_TAG, "%s", buf);
}

/* 只在"有事发生"时调用, 顺手把日志落一份到 state/log 给 App 读 */
static void sk_event(const char *fmt, ...)
{
    char buf[512];
    va_list ap;
    va_start(ap, fmt);
    vsnprintf(buf, sizeof(buf), fmt, ap);
    va_end(ap);
    __android_log_print(ANDROID_LOG_INFO, SK_TAG, "%s", buf);

    struct stat st;
    if (stat(SK_LOG, &st) == 0 && st.st_size > 48 * 1024) {
        unlink(SK_LOG);
    }
    int fd = open(SK_LOG, O_WRONLY | O_CREAT | O_APPEND, 0644);
    if (fd < 0) {
        return;
    }
    char line[640];
    int n = snprintf(line, sizeof(line), "%lld %s\n", sk_wall_s(), buf);
    if (n > 0) {
        ssize_t ignored = write(fd, line, (size_t) n);
        (void) ignored;
    }
    close(fd);
}

static void sk_heartbeat(const char *name)
{
    char path[256], val[32];
    snprintf(path, sizeof(path), SK_STATE "/hb_%s", name);
    snprintf(val, sizeof(val), "%lld", sk_wall_s());
    sk_write_str(path, val);
}

/* 返回心跳年龄(秒); 文件不存在时返回很大的值 */
static int sk_hb_age(const char *name)
{
    char path[256], buf[64];
    snprintf(path, sizeof(path), SK_STATE "/hb_%s", name);
    if (sk_read_file(path, buf, sizeof(buf)) <= 0) {
        return 1000000;
    }
    long long ts = atoll(buf);
    long long age = sk_wall_s() - ts;
    return age < 0 ? 0 : (int) age;
}

static void sk_pidfile(const char *name, pid_t pid)
{
    char path[256], val[32];
    snprintf(path, sizeof(path), SK_STATE "/%s.pid", name);
    snprintf(val, sizeof(val), "%d", (int) pid);
    sk_write_str(path, val);
}

/* 紧急退出标记: 只要有一条路径存在就认 */
static int sk_stop_requested(void)
{
    if (access(SK_STOP1, F_OK) == 0) {
        return 1;
    }
    if (access(SK_STOP2, F_OK) == 0) {
        return 1;
    }
    return 0;
}

/* --------------------------------------------------------------- /proc */

/* 读 status 里的 Uid/PPid/State。成功返回 0。 */
static int sk_proc_status(pid_t pid, int *uid, int *ppid, char *state)
{
    char path[64], buf[1024];
    snprintf(path, sizeof(path), "/proc/%d/status", (int) pid);
    if (sk_read_file(path, buf, sizeof(buf)) <= 0) {
        return -1;
    }
    char *p;
    if (uid) {
        *uid = -1;
        p = strstr(buf, "\nUid:");
        if (p) {
            *uid = (int) strtol(p + 5, NULL, 10);
        }
    }
    if (ppid) {
        *ppid = -1;
        p = strstr(buf, "\nPPid:");
        if (p) {
            *ppid = (int) strtol(p + 6, NULL, 10);
        }
    }
    if (state) {
        *state = '?';
        p = strstr(buf, "\nState:");
        if (p) {
            *state = p[7] == ' ' ? p[8] : p[7];
        }
    }
    return 0;
}

/* cmdline 里的 \0 全部换成空格 */
static int sk_cmdline(pid_t pid, char *out, size_t sz)
{
    char path[64];
    snprintf(path, sizeof(path), "/proc/%d/cmdline", (int) pid);
    int n = sk_read_file(path, out, sz);
    if (n <= 0) {
        return -1;
    }
    for (int i = 0; i < n; i++) {
        if (out[i] == 0) {
            out[i] = ' ';
        }
    }
    while (n > 0 && out[n - 1] == ' ') {
        out[--n] = 0;
    }
    return n;
}

/* 按 comm(内核里的进程名, 最长 15 字符)找 pid, 找不到返回 -1 */
static pid_t sk_pid_by_comm(const char *want)
{
    DIR *d = opendir("/proc");
    if (!d) {
        return -1;
    }
    pid_t found = -1;
    struct dirent *de;
    while ((de = readdir(d)) != NULL) {
        if (!isdigit((unsigned char) de->d_name[0])) {
            continue;
        }
        char path[64], buf[64];
        snprintf(path, sizeof(path), "/proc/%s/comm", de->d_name);
        if (sk_read_file(path, buf, sizeof(buf)) <= 0) {
            continue;
        }
        char *nl = strchr(buf, '\n');
        if (nl) {
            *nl = 0;
        }
        if (strcmp(buf, want) == 0) {
            found = (pid_t) atoi(de->d_name);
            break;
        }
    }
    closedir(d);
    return found;
}

static int sk_pkg_installed(void)
{
    char out[512] = {0};
    FILE *fp = popen("pm path " SK_PKG " 2>/dev/null", "r");
    if (!fp) {
        return 1;                       /* 查不了就别自断 */
    }
    size_t n = fread(out, 1, sizeof(out) - 1, fp);
    out[n] = 0;
    pclose(fp);
    return strstr(out, "package:") != NULL;
}

/* 跑一条命令并拿输出; out 可为 NULL。返回 shell 退出码, -1 表示起不来 */
static int sk_run(const char *cmd, char *out, size_t out_sz)
{
    FILE *fp = popen(cmd, "r");
    if (!fp) {
        return -1;
    }
    if (out && out_sz > 0) {
        size_t n = fread(out, 1, out_sz - 1, fp);
        out[n] = 0;
    } else {
        char sink[256];
        while (fread(sink, 1, sizeof(sink), fp) > 0) {
        }
    }
    int st = pclose(fp);
    if (WIFEXITED(st)) {
        return WEXITSTATUS(st);
    }
    return -1;
}

/* ------------------------------------------------------- 从 APK 取 ELF */

static unsigned int sk_rd16(const unsigned char *p)
{
    return (unsigned int) p[0] | ((unsigned int) p[1] << 8);
}

static unsigned int sk_rd32(const unsigned char *p)
{
    return (unsigned int) p[0] | ((unsigned int) p[1] << 8)
           | ((unsigned int) p[2] << 16) | ((unsigned int) p[3] << 24);
}

/*
 * 从 zip 里取出一个 STORED(不压缩)条目。
 * 构建时 assets/sk/*.so 被强制 STORE, 所以这里不需要 inflate —— 少链一个 libz。
 * 返回 0 成功, -1 打开/查找失败, -2 条目被压缩(构建配置不对)。
 */
static int sk_zip_extract(const char *zip, const char *want,
                          unsigned char **out, size_t *out_len)
{
    int fd = open(zip, O_RDONLY);
    if (fd < 0) {
        return -1;
    }
    off_t size = lseek(fd, 0, SEEK_END);
    if (size < 64) {
        close(fd);
        return -1;
    }
    size_t tail = (size_t) (size < 66560 ? size : 66560);
    unsigned char *buf = (unsigned char *) malloc(tail);
    if (!buf) {
        close(fd);
        return -1;
    }
    if (pread(fd, buf, tail, size - (off_t) tail) != (ssize_t) tail) {
        free(buf);
        close(fd);
        return -1;
    }

    ssize_t eocd = -1;
    for (ssize_t i = (ssize_t) tail - 22; i >= 0; i--) {
        if (sk_rd32(buf + i) == 0x06054b50U) {
            eocd = i;
            break;
        }
    }
    if (eocd < 0) {
        free(buf);
        close(fd);
        return -1;
    }
    unsigned int cd_size = sk_rd32(buf + eocd + 12);
    unsigned int cd_off = sk_rd32(buf + eocd + 16);
    free(buf);

    if (cd_size == 0 || cd_size > 8 * 1024 * 1024) {
        close(fd);
        return -1;
    }
    unsigned char *cd = (unsigned char *) malloc(cd_size);
    if (!cd) {
        close(fd);
        return -1;
    }
    if (pread(fd, cd, cd_size, (off_t) cd_off) != (ssize_t) cd_size) {
        free(cd);
        close(fd);
        return -1;
    }

    size_t want_len = strlen(want);
    unsigned int p = 0;
    int rc = -1;
    while (p + 46 <= cd_size) {
        if (sk_rd32(cd + p) != 0x02014b50U) {
            break;
        }
        unsigned int method = sk_rd16(cd + p + 10);
        unsigned int comp_size = sk_rd32(cd + p + 20);
        unsigned int name_len = sk_rd16(cd + p + 28);
        unsigned int extra_len = sk_rd16(cd + p + 30);
        unsigned int comment_len = sk_rd16(cd + p + 32);
        unsigned int local_off = sk_rd32(cd + p + 42);
        if (p + 46 + name_len > cd_size) {
            break;
        }
        const char *name = (const char *) (cd + p + 46);
        if (name_len == want_len && memcmp(name, want, want_len) == 0) {
            if (method != 0) {
                rc = -2;
                break;
            }
            unsigned char lh[30];
            if (pread(fd, lh, 30, (off_t) local_off) != 30
                    || sk_rd32(lh) != 0x04034b50U) {
                break;
            }
            unsigned int l_name = sk_rd16(lh + 26);
            unsigned int l_extra = sk_rd16(lh + 28);
            off_t data_off = (off_t) local_off + 30 + l_name + l_extra;
            unsigned char *data = (unsigned char *) malloc(comp_size ? comp_size : 1);
            if (!data) {
                break;
            }
            if (pread(fd, data, comp_size, data_off) != (ssize_t) comp_size) {
                free(data);
                break;
            }
            *out = data;
            *out_len = comp_size;
            rc = 0;
            break;
        }
        p += 46 + name_len + extra_len + comment_len;
    }
    free(cd);
    close(fd);
    return rc;
}

/* 用 sk_boot 重新拉起一个载荷: ELF 由本进程从 APK 读出, 走管道送进去 */
static int sk_spawn(const char *apk, const char *entry)
{
    char want[128];
    snprintf(want, sizeof(want), "assets/sk/%s.so", entry);

    unsigned char *elf = NULL;
    size_t elf_len = 0;
    int rc = sk_zip_extract(apk, want, &elf, &elf_len);
    if (rc != 0) {
        sk_event("spawn %s: 取 ELF 失败 rc=%d (apk=%s)", entry, rc, apk);
        return -1;
    }

    int pfd[2];
    if (pipe(pfd) != 0) {
        free(elf);
        return -1;
    }
    pid_t pid = fork();
    if (pid == 0) {
        dup2(pfd[0], 0);
        close(pfd[0]);
        close(pfd[1]);
        int devnull = open("/dev/null", O_WRONLY);
        if (devnull >= 0) {
            dup2(devnull, 1);
            dup2(devnull, 2);
        }
        execl(SK_BOOT, SK_BOOT, apk, entry, (char *) NULL);
        _exit(127);
    }
    close(pfd[0]);
    if (pid < 0) {
        close(pfd[1]);
        free(elf);
        return -1;
    }
    size_t off = 0;
    while (off < elf_len) {
        ssize_t n = write(pfd[1], elf + off, elf_len - off);
        if (n <= 0) {
            break;
        }
        off += (size_t) n;
    }
    close(pfd[1]);
    free(elf);

    int st = 0;
    waitpid(pid, &st, 0);
    if (!WIFEXITED(st) || WEXITSTATUS(st) != 0) {
        sk_event("spawn %s: boot 退出异常 st=%d", entry, st);
        return -1;
    }
    pid_t child = sk_pid_by_comm(entry);
    sk_event("spawn %s: 已拉起 pid=%d", entry, (int) child);
    return child > 0 ? 0 : -1;
}

/* 兄弟进程死了就补一个(先看心跳, 再看进程, 避免重复拉起) */
static void sk_ensure_peer(const char *apk, const char *peer, int stale_s)
{
    if (sk_hb_age(peer) <= stale_s) {
        return;
    }
    if (sk_pid_by_comm(peer) > 0) {
        return;
    }
    sk_spawn(apk, peer);
}

#endif /* SK_COMMON_H */
