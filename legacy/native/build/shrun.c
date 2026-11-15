// ============================================================================
// shrun — 把 shell 脚本跑在匿名内存里,磁盘上不留文件
//
// 用法:
//   echo '<脚本>' | shrun          # 脚本从 stdin 进内存
//   shrun -c '<脚本>'               # 从参数(会留在 argv,不推荐)
//
// 原理:
//   ① memfd_create("x", 0)        ← 向内核要一块"没有名字的文件"
//                                    不带 MFD_CLOEXEC,这样 exec 后 fd 仍保留
//   ② write() 把脚本写进去
//   ③ fork + setsid                ← 脱离 adb shell 会话
//   ④ execve("/system/bin/sh",
//            {sh, "/proc/self/fd/N"})  ← sh 用这个路径读出内存里的脚本
//
//   磁盘上不存在这个脚本。`find / -name xxx` 搜不到,`/proc/<pid>/cmdline`
//   里只有 "sh /proc/self/fd/7" 这种,看不到脚本内容。
//
//   对比直接 `setsid sh -c '整段脚本'`:
//     - sh -c 的整段脚本会明文躺在 /proc/<pid>/cmdline 里,ps 一眼可见
//     - shrun 的 cmdline 只有路径
//
// 退出码:
//   0   已 fork,子进程已交给 sh
//   10  内存分配失败
//   11  读 stdin 失败
//   12  脚本太短(<2 字节)
//   13  memfd_create 失败
//   14  写 memfd 失败
//   15  fork 失败
//   127 execve 失败
// ============================================================================

#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/prctl.h>
#include <sys/syscall.h>
#include <sys/types.h>

#ifndef SYS_memfd_create
#define SYS_memfd_create 279        /* arm64 与 x86_64 同号 */
#endif

#define MAX_SCRIPT (1024 * 1024)    /* 1 MB 上限,守护脚本远用不到 */

extern char **environ;

/* 把 fd 里所有内容读进 buf,返回实际长度;失败返回 -1 */
static ssize_t read_all(int fd, char *buf, size_t cap)
{
    size_t n = 0;
    for (;;) {
        if (n >= cap)
            return -1;
        ssize_t r = read(fd, buf + n, cap - n);
        if (r < 0) {
            if (errno == EINTR)
                continue;
            return -1;
        }
        if (r == 0)
            break;
        n += (size_t) r;
    }
    return (ssize_t) n;
}

int main(int argc, char **argv)
{
    char *script = (char *) malloc(MAX_SCRIPT);
    if (!script)
        return 10;

    /* 解析参数:
     *   shrun                  → 从 stdin 读
     *   shrun -c S             → 从参数读
     *   shrun -t TAG           → stdin 读,子进程 argv[0] = TAG
     *   shrun -t TAG -c S      → 两者都用
     * -t 的作用:把子进程的 cmdline 变成 "<TAG> /proc/self/fd/N",
     * 这样外部(比如紧急退出的 kill 脚本)能用 TAG 精确匹配,
     * 而不用去匹配 /proc/self/fd/<n> 那种会误伤一大片的模式。
     */
    const char *tag = NULL;
    const char *inline_script = NULL;
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-t") == 0 && i + 1 < argc)
            tag = argv[++i];
        else if (strcmp(argv[i], "-c") == 0 && i + 1 < argc)
            inline_script = argv[++i];
    }

    ssize_t len;
    if (inline_script) {
        len = (ssize_t) strlen(inline_script);
        if (len >= MAX_SCRIPT) {
            free(script);
            return 10;
        }
        memcpy(script, inline_script, (size_t) len);
    } else {
        len = read_all(0, script, MAX_SCRIPT);
        if (len < 0) {
            free(script);
            return 11;
        }
    }
    if (len < 2) {
        free(script);
        return 12;
    }

    /* 不带 MFD_CLOEXEC:exec 之后这个 fd 必须还开着,sh 才能读到 */
    int fd = (int) syscall(SYS_memfd_create, "x", 0u);
    if (fd < 0) {
        free(script);
        return 13;
    }

    /* 极小概率:0/1/2 被关闭时 memfd 会占用低号 fd,
       后面 dup2(/dev/null) 会把它覆盖掉。挪到 >= 3 更安全。 */
    if (fd < 3) {
        int nfd = fcntl(fd, F_DUPFD, 3);
        close(fd);
        if (nfd < 0) {
            free(script);
            return 13;
        }
        fd = nfd;
    }

    size_t off = 0;
    while (off < (size_t) len) {
        ssize_t w = write(fd, script + off, (size_t) len - off);
        if (w <= 0) {
            if (errno == EINTR)
                continue;
            close(fd);
            free(script);
            return 14;
        }
        off += (size_t) w;
    }
    free(script);

    char path[64];
    snprintf(path, sizeof(path), "/proc/self/fd/%d", fd);

    pid_t pid = fork();
    if (pid < 0) {
        close(fd);
        return 15;
    }
    if (pid > 0)
        return 0;                   /* 父进程立刻退出,不占着 adb shell */

    /* ---- 子进程:脱离会话,静默,换名 ---- */
    setsid();
    signal(SIGHUP, SIG_IGN);
    signal(SIGPIPE, SIG_IGN);
    prctl(PR_SET_NAME, "sh", 0, 0, 0);

    int dn = open("/dev/null", O_RDWR);
    if (dn >= 0) {
        dup2(dn, 0);
        dup2(dn, 1);
        dup2(dn, 2);
        if (dn > 2)
            close(dn);
    }

    /* argv[0] 用 tag 替代 "/system/bin/sh",让 /proc/<pid>/cmdline 变成
       "<TAG> /proc/self/fd/N",外部 kill 脚本可以按 TAG 精确匹配。
       注意 argv[0] 只是显示名,真正执行的仍是 /system/bin/sh(第一个参数)。 */
    char *nargv[] = { (char *) (tag ? tag : "/system/bin/sh"), path, NULL };
    execve("/system/bin/sh", nargv, environ);

    _exit(127);
}
