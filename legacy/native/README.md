# KeeperNative

Keeper 旧版 native 载荷（精简版）源码。

- `src/` — 原始 C 源码，5 个文件，未改动
- `merged/` — 精简合并版：`sk_sweep` / `sk_revive` / `sk_guard` 编进同一个 `keeper.so`，`sk_core.c` 按 entry 名分派；`sk_guard.c` 加入 ptrace 冻结-反杀
- `build/build_legacy.sh` — 本地/CI 编译脚本，产出 `_legacy_out/keeper.bin` + `keeper.so`
- `build/ptrace_probe.c` — ATTACH 能力探针
- `patch/` — 旧版 smali 补丁与公开仓库推送脚本（REST Git Data API）
- `tools/verify_device.sh` — 真机验证脚本（force-stop / disable-user 拦截）
- `artifacts/` — CI 最近一次产物的副本，仅方便取用；权威来源是源码 + CI
- `TODO.txt` — 待办与已知风险

## 构建

```bash
export ANDROID_NDK_HOME=/path/to/android-ndk-r27c
bash build/build_legacy.sh
```

产物：

```
_legacy_out/keeper.bin   加载器（PIE，必须动态链接）
_legacy_out/keeper.so    三合一载荷（sweep + revive + guard）
```

## CI（仓库根）

- `../../.github/workflows/build-native.yml` — 编译本目录，上传 `keeper-native` artifact
- `../../.github/workflows/build-legacy.yml` — 编译 native → 替换 APK 的 4 个 assets →
  断言全部 STORED 且与 `_legacy_out` 字节一致 → 重打包签名，上传 `keeper-legacy-patched`

## 装机

```
keeper.bin -> assets/sk/boot
keeper.so  -> assets/sk/sk_sweep.so
keeper.so  -> assets/sk/sk_revive.so
keeper.so  -> assets/sk/sk_guard.so
```

然后 `apktool b` + v3 签名。`keeper.bin` 不能加 `-static`：静态进程没有 linker，
`android_dlopen_ext` 会失败。

## 真机验证（TODO #2）

前提：手机已开 USB 调试并授权；App 已完成无线调试配对/激活（三路 pid 都在）。

```bash
ADB=/path/to/adb bash tools/verify_device.sh \
  /path/to/Keeper_legacy_unsigned-aligned-debugSigned.apk --fresh
```

脚本做四件事：

1. 安装/启动，核对 `sweep/revive/guard` 三路 pid 与 `/proc/<pid>/comm`
2. 从 **detached shell**（ppid 1，模拟对手，不是 adbd）发 `am force-stop`，
   检查 App pid 不变、`state/blocked` 递增、logcat 出现 `guard: ptrace 冻住`
3. 同样方式发 `pm disable-user`，检查包没被禁用
4. 打印 `state/{hits,blocked,blocked_last,log}`

退出码：0 全过；1 有失败；2 载荷没齐（还没激活）。

注意：从电脑直接 `adb shell am force-stop com.sk.keeper` 会被 guard **放行**
（祖先是 adbd，判为用户手敲），这不代表拦截失效；脚本用的是 detached shell。
