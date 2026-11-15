Keeper 旧版 native 源码包  ·  2026-11-15
==========================================

一、目录说明
  src/      V 盘拿回来的原始 C 源码，5 个文件，一个字没改
  merged/   精简合并版（在 src 基础上改），多一个 sk_core.c
  build/    NDK 编译脚本 + ptrace 探针 + shrun
  patch/    旧版 smali 补丁脚本、公开仓库推送脚本
  TODO.txt  还差什么（重点看这个）

二、三套东西的关系
  原版架构：boot(可执行) + sk_sweep.so / sk_revive.so / sk_guard.so
            三个 so 各自导出 sk_main，boot 按 argv[2] 从 APK 取对应 so
            灌进 memfd，用 android_dlopen_ext 匿名加载。
            sk_common.h 里的 sk_spawn/sk_ensure_peer 负责三兄弟互拉。

  精简架构：编译产物只剩 2 个
            keeper.bin  —— 由 sk_boot.c 编来，加载器，必须动态链接
            keeper.so   —— 三个 payload 分别编译成 .o 再和 sk_core.c 链接
            sk_core.c 按 argv[1]（entry 名）分派到对应循环。
            APK 里 assets/sk/sk_{sweep,revive,guard}.so 三个名字
            放同一份 keeper.so，boot 放 keeper.bin。
            => smali 一行没改，互拉/心跳/pidfile 全部照常。

三、已经做完并验证的
  - ptrace 实测：ANG-AN00（华为，Android 12，无 root、无 Yama），
    PTRACE_ATTACH=0，waitpid 收到 SIGSTOP，能冻住同 uid 兄弟进程。
  - guard 反杀改成「ATTACH 冻住 -> SIGKILL -> 回收」，
    消除了「kill 信号没送到但 Binder 已经调完」的竞态；
    ATTACH 失败自动回退裸 kill。原始 src/ 保持不动，只改 merged/。
  - CI 编译通过：keeper.bin 10,064 B、keeper.so 34,696 B（AArch64）。
  - 本地替换 assets 后 apktool b + v3 签名通过，最终包 7,034,543 B。

四、怎么重编
  需要 Android NDK（aarch64-linux-android30-clang）。
    bash native/build_legacy.sh
  产物在 _legacy_out/：keeper.bin、keeper.so
  然后：
    cp keeper.bin  <dec>/assets/sk/boot
    cp keeper.so   <dec>/assets/sk/sk_sweep.so   (三份同名副本)
    ...
    java -jar apktool.jar b <dec> -o unsigned.apk
    java -jar uber-apk-signer.jar -a unsigned.apk --allowResign -o out

  注意：keeper.bin 不能加 -static。静态进程里没有 linker，
  android_dlopen_ext 会失败。

五、几个源码里的重要常数
  GUARD_INTERVAL_US  10000   guard 10ms 一轮（比新版 shield 的 100ms 快 10 倍）
  REVIVE_INTERVAL_MS 900
  SWEEP_INTERVAL_MS  1000
  SK_BOOT  /data/local/tmp/.sk/boot
  SK_PKG   com.sk.keeper
  state/blocked      只是累计次数（"1" "2" ...）
  state/blocked_last 格式 "pid=N target=com.sk.keeper ..."，带 pid 所以每次都不同
