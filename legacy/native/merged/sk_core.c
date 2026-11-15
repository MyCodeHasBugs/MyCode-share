/*
 * sk_core —— 三合一分派入口
 *
 * 原来 sweep / revive / guard 是三个独立 .so, 各自导出 sk_main,
 * boot 按 argv[2] 的名字从 APK 里取对应的 so 灌进 memfd。
 *
 * 现在把三者编进同一个 keeper.so, 用 -Dsk_main=sk_xxx_main 分别重命名,
 * 这里再按 argv[1] (entry 名) 分派。boot 的代码一行不用改,
 * sk_common.h 里的 sk_spawn/sk_ensure_peer 也照常工作 ——
 * 它们仍然按 "assets/sk/<entry>.so" 取文件, 只是三个名字指向同一份内容。
 *
 * argv 沿用 boot 传下来的 [apk路径, entry名]。
 */
#include <string.h>

int sk_sweep_main(int argc, char **argv);
int sk_revive_main(int argc, char **argv);
int sk_guard_main(int argc, char **argv);

int sk_main(int argc, char **argv)
{
    const char *entry = (argc > 1 && argv[1]) ? argv[1] : "sk_guard";

    if (strcmp(entry, "sk_sweep") == 0) {
        return sk_sweep_main(argc, argv);
    }
    if (strcmp(entry, "sk_revive") == 0) {
        return sk_revive_main(argc, argv);
    }
    return sk_guard_main(argc, argv);
}
