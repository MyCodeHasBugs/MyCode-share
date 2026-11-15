#!/usr/bin/env bash
# =============================================================================
# 编译 ptrace_probe —— 验证 shell 域能否 ptrace 同 uid 进程的小探针
# 产物:_probe/ptrace_probe(静态链接,arm64)
# =============================================================================
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP="$(cd "$HERE/../app" && pwd)"
OUT_DIR="$APP/../_probe"
OUT="$OUT_DIR/ptrace_probe"

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

mkdir -p "$OUT_DIR"

"$CC" -Os -s -fPIE -pie -static -Wall \
  -o "$OUT" \
  "$HERE/ptrace_probe.c"

chmod +x "$OUT"
SIZE=$(stat -c %s "$OUT" 2>/dev/null || stat -f %z "$OUT")
echo "✓ 产出 $OUT ($SIZE 字节)"
file "$OUT" 2>/dev/null || true
