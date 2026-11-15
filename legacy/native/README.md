# KeeperNative

Keeper 旧版 native 载荷（精简版）源码。

- `src/` — 原始 C 源码，5 个文件，未改动
- `merged/` — 精简合并版：`sk_sweep` / `sk_revive` / `sk_guard` 编进同一个 `keeper.so`，`sk_core.c` 按 entry 名分派；`sk_guard.c` 加入 ptrace 冻结-反杀
- `build/build_legacy.sh` — 本地/CI 编译脚本，产出 `_legacy_out/keeper.bin` + `keeper.so`
- `build/ptrace_probe.c` — ATTACH 能力探针
- `patch/` — 旧版 smali 补丁与公开仓库推送脚本（REST Git Data API）
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

## CI

`.github/workflows/build.yml`：push 到 `main` 或手动触发，NDK r27c 编译，
产物以 `keeper-native` artifact 上传。

## 装机

```
keeper.bin -> assets/sk/boot
keeper.so  -> assets/sk/sk_sweep.so
keeper.so  -> assets/sk/sk_revive.so
keeper.so  -> assets/sk/sk_guard.so
```

然后 `apktool b` + v3 签名。`keeper.bin` 不能加 `-static`：静态进程没有 linker，
`android_dlopen_ext` 会失败。
