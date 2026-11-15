/*
 * sk_boot —— 匿名内存加载器
 *
 * 用法:  sk_boot <apk路径> <条目名>   < payload.so
 *
 * 流程:
 *   1. 从 stdin 读完整个 ELF(由 App 通过 adb shell 的 stdin 直接灌进来);
 *   2. memfd_create 建一块匿名文件, 写入并 seal(F_SEAL_WRITE 等), 进程退出后
 *      内核自动回收, 磁盘上不会留任何 .so;
 *   3. fork + setsid 脱离 adb shell 会话(否则 adb 一断就被 SIGHUP 带走);
 *   4. android_dlopen_ext(ANDROID_DLEXT_USE_LIBRARY_FD) 直接从 fd 映射并重定位 ——
 *      这条路绕开 bionic 链接器对路径的命名空间限制, dlopen("/proc/self/fd/N")
 *      在 shell 域会报 "library not found";
 *   5. 调 dlsym("sk_main") 并进入载荷主循环。
 */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <signal.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/prctl.h>
#include <android/dlext.h>
#include <android/log.h>
#include <dlfcn.h>

#ifndef MFD_CLOEXEC
#define MFD_CLOEXEC 0x0001U
#endif
#ifndef MFD_ALLOW_SEALING
#define MFD_ALLOW_SEALING 0x0002U
#endif
#ifndef F_ADD_SEALS
#define F_ADD_SEALS 1033
#endif
#ifndef F_SEAL_SHRINK
#define F_SEAL_SHRINK 0x0002
#endif
#ifndef F_SEAL_GROW
#define F_SEAL_GROW 0x0004
#endif
#ifndef F_SEAL_WRITE
#define F_SEAL_WRITE 0x0008
#endif

#define TAG "Skeeper"
#define MAX_ELF (48 * 1024 * 1024)

static int g_fd = -1;

static unsigned char *read_stdin(size_t *out_len)
{
    size_t cap = 128 * 1024;
    size_t len = 0;
    unsigned char *buf = (unsigned char *) malloc(cap);
    if (!buf) {
        return NULL;
    }
    for (;;) {
        if (len == cap) {
            if (cap >= MAX_ELF) {
                break;
            }
            cap *= 2;
            unsigned char *nb = (unsigned char *) realloc(buf, cap);
            if (!nb) {
                free(buf);
                return NULL;
            }
            buf = nb;
        }
        ssize_t n = read(0, buf + len, cap - len);
        if (n < 0) {
            if (errno == EINTR) {
                continue;
            }
            break;
        }
        if (n == 0) {
            break;
        }
        len += (size_t) n;
    }
    *out_len = len;
    return buf;
}

static int make_memfd(const unsigned char *elf, size_t len)
{
    int fd = (int) syscall(__NR_memfd_create, "sk", MFD_CLOEXEC | MFD_ALLOW_SEALING);
    if (fd < 0) {
        __android_log_print(ANDROID_LOG_ERROR, TAG, "memfd_create: %s", strerror(errno));
        return -1;
    }
    size_t off = 0;
    while (off < len) {
        ssize_t n = write(fd, elf + off, len - off);
        if (n <= 0) {
            __android_log_print(ANDROID_LOG_ERROR, TAG, "memfd write: %s", strerror(errno));
            close(fd);
            return -1;
        }
        off += (size_t) n;
    }
    if (fcntl(fd, F_ADD_SEALS, F_SEAL_SHRINK | F_SEAL_GROW | F_SEAL_WRITE) != 0) {
        __android_log_print(ANDROID_LOG_WARN, TAG, "seal: %s (继续)", strerror(errno));
    }
    return fd;
}

int main(int argc, char **argv)
{
    if (argc < 3) {
        fprintf(stderr, "usage: sk_boot <apk> <entry> < payload\n");
        return 2;
    }
    const char *apk = argv[1];
    const char *entry = argv[2];

    size_t len = 0;
    unsigned char *elf = read_stdin(&len);
    if (!elf || len < 4096 || elf[0] != 0x7f || elf[1] != 'E') {
        __android_log_print(ANDROID_LOG_ERROR, TAG, "stdin 不是 ELF (len=%zu)", len);
        free(elf);
        return 3;
    }

    g_fd = make_memfd(elf, len);
    free(elf);
    if (g_fd < 0) {
        return 4;
    }

    /*
     * adb shell 退出时会向会话进程组发 SIGHUP。先把 SIGHUP 忽略掉,
     * 再 fork + setsid, 避免刚 fork 出来就被带走的那几毫秒窗口。
     */
    signal(SIGHUP, SIG_IGN);
    signal(SIGPIPE, SIG_IGN);

    pid_t pid = fork();
    if (pid > 0) {
        _exit(0);                       /* 父进程立刻返回, 让 adb shell 命令结束 */
    }
    if (pid < 0) {
        return 5;
    }

    setsid();
    prctl(PR_SET_NAME, entry, 0, 0, 0);

    int devnull = open("/dev/null", O_RDWR);
    if (devnull >= 0) {
        dup2(devnull, 0);
        dup2(devnull, 1);
        dup2(devnull, 2);
        if (devnull > 2) {
            close(devnull);
        }
    }

    android_dlextinfo info;
    memset(&info, 0, sizeof(info));
    info.flags = ANDROID_DLEXT_USE_LIBRARY_FD;
    info.library_fd = g_fd;

    void *handle = android_dlopen_ext("libsk_payload.so", RTLD_NOW, &info);
    if (!handle) {
        __android_log_print(ANDROID_LOG_ERROR, TAG, "android_dlopen_ext: %s", dlerror());
        return 6;
    }
    void *sym = dlsym(handle, "sk_main");
    if (!sym) {
        __android_log_print(ANDROID_LOG_ERROR, TAG, "dlsym(sk_main): %s", dlerror());
        return 7;
    }
    __android_log_print(ANDROID_LOG_INFO, TAG,
                        "%s: 已从匿名内存加载 (%zu bytes), uid=%d", entry, len, (int) getuid());
    int (*fn)(int, char **) = (int (*)(int, char **)) sym;
    /*
     * 把 apk 路径与条目名原样交给载荷: sk_main 的 argv[0] 必须是 APK,
     * 否则载荷重启兄弟时找不到自己的 ELF 来源。
     * 传入 [apk, entry], 而不是 [entry]。
     */
    return fn(argc - 1, argv + 1);
}
