/*
 * sk_revive —— 把 App 拉回来
 *
 * App 的四个组件跑在 app uid, 一旦被 force-stop / 划掉 / 系统回收就全没了。
 * 这个载荷跑在 shell uid、独立会话里, 不受那个 cgroup 约束, 于是:
 *
 *   发现 com.sk.keeper 没有进程  ->  am start(顺带清掉 STOPPED 标志)
 *   发现 sk_sweep 心跳停了       ->  从 APK 里取 ELF, 重新拉起它
 *
 * 为什么 am start 能救回被 force-stop 的包:
 *   force-stop 做两件事 —— 按 cgroup 杀进程 + 打 STOPPED 标志(广播全收不到)。
 *   am start 是显式启动, 会把 STOPPED 一并清掉, 之后广播通道也恢复。
 */
#include "sk_common.h"

#define REVIVE_INTERVAL_MS 900

/*
 * 屏幕亮着才值得"拉回前台"。
 * 一次 dumpsys power 大概几十毫秒, 3 秒缓存一次, 不心疼。
 */
static int screen_awake(void)
{
    static long long last = 0;
    static int cached = 1;
    long long now = sk_now_ms();
    if (last != 0 && now - last < 3000) {
        return cached;
    }
    last = now;
    char buf[512] = {0};
    FILE *fp = popen("dumpsys power 2>/dev/null | grep -m1 mWakefulness=", "r");
    if (!fp) {
        cached = 1;
        return 1;
    }
    size_t n = fread(buf, 1, sizeof(buf) - 1, fp);
    buf[n] = 0;
    pclose(fp);
    if (n == 0) {
        cached = 1;
        return 1;
    }
    cached = strstr(buf, "Awake") != NULL;
    return cached;
}

/*
 * App 是不是在前台。
 *
 * 实测: 前台 oom_score_adj=0, 退到后台(有前台服务吊着)=50。
 * 所以 adj>0 就认为不在前台 —— 进程还在, 但用户看不见它。
 * 这正是"挪进后台就不拉了"的根因: 老逻辑只判断进程存不存在。
 */
/* 逃生开关: 有这个文件就只"拉活"、不"拽前台" */
static int pull_disabled(void)
{
    return access(SK_STATE "/no_pull", F_OK) == 0;
}

static int app_foreground(pid_t pid)
{
    char path[64], buf[32];
    snprintf(path, sizeof(path), "/proc/%d/oom_score_adj", (int) pid);
    if (sk_read_file(path, buf, sizeof(buf)) <= 0) {
        return 0;
    }
    return atoi(buf) <= 0;
}

int sk_main(int argc, char **argv)
{
    char apk[512] = {0};
    if (argc > 0 && argv[0]) {
        snprintf(apk, sizeof(apk), "%s", argv[0]);
    }
    prctl(PR_SET_NAME, "sk_revive", 0, 0, 0);
    signal(SIGPIPE, SIG_IGN);
    signal(SIGHUP, SIG_IGN);

    sk_pidfile("revive", getpid());
    sk_event("revive: 启动 uid=%d apk=%s", (int) getuid(), apk);

    int guard = 0;
    int pkg_check = 0;
    int installed = 1;

    for (;;) {
        if (sk_stop_requested()) {
            sk_event("revive: 收到紧急退出标记, 停止");
            break;
        }
        sk_heartbeat("revive");

        if (++pkg_check >= 20) {
            pkg_check = 0;
            installed = sk_pkg_installed();
        }
        if (!installed) {
            sk_event("revive: App 已卸载, 退出");
            break;
        }

        pid_t app = sk_pid_by_comm(SK_PKG);
        if (app <= 0) {
            char out[512] = {0};
            int rc = sk_run("am start -n " SK_ACT " --ez sk_revive true 2>&1",
                            out, sizeof(out));
            /*
             * 启动失败最常见的原因是包被 `pm disable-user` 了(别的应用拿到
             * shell 后干的)。am start 会报 "not installed for user" /
             * "does not exist"; 这时先 pm enable 再试一次。
             * pm enable 是幂等的, 但只在失败路径上执行, 免得每 0.9 秒跑一条。
             */
            if (rc != 0 || strstr(out, "Error") != NULL
                    || strstr(out, "does not exist") != NULL) {
                sk_event("revive: am start 失败(%s), 先 enable 再试",
                         strstr(out, "Error") ? "Error" : "not-installed");
                sk_run("pm enable --user 0 " SK_PKG " >/dev/null 2>&1", NULL, 0);
                sk_run("am start -n " SK_ACT " --ez sk_revive true >/dev/null 2>&1",
                       NULL, 0);
            } else {
                sk_event("revive: App 不在, am start");
            }
            usleep(1200 * 1000);
        } else if (!pull_disabled() && screen_awake() && !app_foreground(app)) {
            /*
             * 进程活着但不在前台(退到后台 / 划掉任务但服务还吊着)。
             * 这里不带 --ez sk_revive: 只是把已有任务提到前台, 不要触发重新部署。
             */
            sk_event("revive: App 退到后台(adj>0), 拉回前台");
            sk_run("am start -n " SK_ACT " >/dev/null 2>&1", NULL, 0);
            usleep(1500 * 1000);
        }

        if (++guard >= 5) {
            guard = 0;
            if (apk[0]) {
                sk_ensure_peer(apk, "sk_sweep", 12);
            }
        }
        usleep(REVIVE_INTERVAL_MS * 1000);
    }

    unlink(SK_STATE "/revive.pid");
    return 0;
}
