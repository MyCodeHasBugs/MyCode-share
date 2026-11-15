// ============================================================================
// ptrace_probe —— 验证 shell 域内能否 ptrace 同 uid 的非子进程
//
// 背景:Android 上通常有 Yama 的 ptrace_scope=1 限制,只能 ptrace 自己的子进程。
// 但这台设备的内核里 /proc/sys/kernel/yama/ 整个目录都不存在,说明 Yama 没开,
// 那么同 uid(2000) 之间的 ptrace 就只取决于 SELinux 的 process ptrace 权限。
//
// 用法:
//   ptrace_probe <pid>       # 附加、读一次寄存器、再 detach
//   ptrace_probe -s <pid>    # 附加后保持暂停 3 秒再 detach(观察目标是否真的停住)
//
// 退出码:
//   0  能附加
//   1  附加失败(errno 会打出来)
//   2  参数错误
// ============================================================================

#define _GNU_SOURCE
#include <errno.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/ptrace.h>
#include <sys/user.h>
#include <sys/wait.h>

int main(int argc, char **argv)
{
    int hold = 0;
    int idx = 1;

    if (argc < 2) {
        printf("usage: %s [-s] <pid>\n", argv[0]);
        return 2;
    }
    if (strcmp(argv[1], "-s") == 0) {
        hold = 1;
        idx = 2;
    }
    if (idx >= argc) {
        printf("usage: %s [-s] <pid>\n", argv[0]);
        return 2;
    }

    int pid = atoi(argv[idx]);
    printf("self=%d(uid=%d) target=%d\n", getpid(), getuid(), pid);

    errno = 0;
    long r = ptrace(PTRACE_ATTACH, pid, NULL, NULL);
    printf("PTRACE_ATTACH  = %ld  errno=%d (%s)\n", r, errno, strerror(errno));
    if (r != 0) {
        return 1;
    }

    int st = 0;
    pid_t w = waitpid(pid, &st, 0);
    printf("waitpid        = %d  stopped=%d  sig=%d\n",
           (int) w, WIFSTOPPED(st), WIFSTOPPED(st) ? WSTOPSIG(st) : -1);

    // 不读寄存器:bionic 的 <sys/user.h> 里没有 user_regs_struct(只有 user_pt_regs),
    // 而 aarch64 上 PTRACE_GETREGS 也不保证可用。ATTACH 成功 + waitpid 看到停止,
    // 已经足够证明"能附加、能冻住"这件事了。

    if (hold) {
        printf("保持暂停 3 秒…\n");
        sleep(3);
    }

    errno = 0;
    long d = ptrace(PTRACE_DETACH, pid, NULL, NULL);
    printf("PTRACE_DETACH  = %ld  errno=%d (%s)\n", d, errno, strerror(errno));

    return 0;
}
