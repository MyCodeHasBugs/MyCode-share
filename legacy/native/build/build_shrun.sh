#!/usr/bin/env bash
# 编译 shrun —— 匿名内存脚本执行器
#
# 产物: app/src/main/assets/sk/shrun
# 推送: adb push app/src/main/assets/sk/shrun /data/local/tmp/.sk/shrun
#       adb shell chmod 755 /data/local/tmp/.sk/shrun
#
# 用法(脚本从 stdin 进,不落盘):
#   echo '<脚本>' | /data/local/tmp/.sk/shrun
#
# 需要 NDK。设置 CC,或者让脚本自己找:
#   export NDK=$HOME/android-ndk-r26
#   bash native/build_shrun.sh

set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
OUT_DIR="$HERE/../app/src/main/assets/sk"
mkdir -p "$OUT_DIR"

# ---- 找编译器 ----
if [ -z "${CC:-}" ]; then
    for cand in \
        "${NDK:-}/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android30-clang" \
        "${ANDROID_NDK_HOME:-}/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android30-clang" \
        "$HOME/android-ndk-r26/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android30-clang" \
        "aarch64-linux-android30-clang"
    do
        if command -v "$cand" >/dev/null 2>&1; then
            CC="$cand"
            break
        fi
    done
fi

if [ -z "${CC:-}" ]; then
    echo "找不到 aarch64-linux-android30-clang,请设置 CC 或 NDK" >&2
    exit 1
fi

echo "编译器: $CC"

# -O2      优化,守护循环对性能不敏感但体积小
# -s       strip,减小体积
# -fPIE -pie  位置无关
# 静态链不需要:shrun 只做 memfd + execve,不 unlink 自己
"$CC" \
    -O2 -s \
    -fPIE -pie \
    -Wall -Wextra \
    -o "$OUT_DIR/shrun" \
    "$HERE/shrun.c"

SIZE=$(stat -c %s "$OUT_DIR/shrun" 2>/dev/null || wc -c < "$OUT_DIR/shrun")
echo "✓ 产出 $OUT_DIR/shrun (${SIZE} 字节)"
file "$OUT_DIR/shrun" 2>/dev/null || true
