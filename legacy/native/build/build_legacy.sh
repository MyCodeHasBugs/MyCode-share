#!/usr/bin/env bash
# =============================================================================
# 编译旧版精简版 native:只产出 2 个文件
#
#   _legacy_out/keeper.bin   加载器(由 sk_boot.c 来,匿名内存加载 so)
#   _legacy_out/keeper.so    三合一载荷(sweep + revive + guard)
#
# 三个 payload 各自单独编译成 .o(-Dsk_main=sk_xxx_main 重命名入口),
# 再和 sk_core.c 链接成一个 .so。分开编译是必须的:三个 .c 里都有
# static 全局变量,塞进同一个编译单元会重名。
#
# boot 必须动态链接:静态进程里没有 linker,android_dlopen_ext 会失败。
# =============================================================================
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$HERE/../merged"
OUT_DIR="$HERE/../_legacy_out"
mkdir -p "$OUT_DIR"

if [ -z "${NDK:-}" ]; then
  for cand in \
      "$ANDROID_NDK_HOME" \
      "$ANDROID_HOME/ndk"/* \
      "$HOME/Android/Sdk/ndk"/* ; do
    if [ -d "$cand/toolchains/llvm/prebuilt" ]; then
      NDK="$cand"
      break
    fi
  done
fi

if [ -z "${NDK:-}" ] || [ ! -d "$NDK" ]; then
  echo "✗ 找不到 NDK" >&2
  exit 1
fi

HOST_TAG="$(ls "$NDK/toolchains/llvm/prebuilt" | head -1)"
CC="$NDK/toolchains/llvm/prebuilt/$HOST_TAG/bin/aarch64-linux-android30-clang"
CFLAGS="-Os -fPIC -Wall -Wno-unused-function"

for m in sweep revive guard; do
  echo "  编译 sk_${m}.c"
  "$CC" $CFLAGS \
    -Dsk_main="sk_${m}_main" \
    -I"$SRC" \
    -c "$SRC/sk_${m}.c" -o "$OUT_DIR/sk_${m}.o"
done

echo "  编译 sk_core.c"
"$CC" $CFLAGS -I"$SRC" -c "$SRC/sk_core.c" -o "$OUT_DIR/sk_core.o"

echo "  链接 keeper.so"
"$CC" -shared -o "$OUT_DIR/keeper.so" \
  "$OUT_DIR/sk_core.o" \
  "$OUT_DIR/sk_sweep.o" \
  "$OUT_DIR/sk_revive.o" \
  "$OUT_DIR/sk_guard.o" \
  -llog

echo "  编译 keeper.bin"
"$CC" -Os -fPIE -pie -Wall \
  -I"$SRC" \
  -o "$OUT_DIR/keeper.bin" \
  "$SRC/sk_boot.c" \
  -ldl -llog

chmod 755 "$OUT_DIR/keeper.bin"
echo "✓ 产物:"
for f in keeper.bin keeper.so; do
  printf '  %-14s %8d B\n' "$f" "$(stat -c %s "$OUT_DIR/$f" 2>/dev/null || stat -f %z "$OUT_DIR/$f")"
done
file "$OUT_DIR/keeper.bin" "$OUT_DIR/keeper.so" 2>/dev/null || true
