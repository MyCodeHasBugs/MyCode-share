#!/usr/bin/env bash
# =============================================================================
# Keeper legacy 真机验证（TODO #2）
#
# 前提：
#   1. 手机已开 USB 调试并授权本机（adb devices 能看到 device）
#   2. App 已经完成配对/激活，/data/local/tmp/.sk/state 下有三路 pid
#   3. 只用于你自己的测试机；会主动触发 force-stop / disable-user
#
# 用法：
#   ADB=/path/to/adb ./verify_device.sh [apk] [--fresh] [--no-install]
#
#   --fresh       签名不一致时先 uninstall（会清 App 数据）
#   --no-install  跳过安装，直接验证已装的包
#
# 退出码：0 全过；1 有失败；2 还没激活（缺载荷）
# =============================================================================
set -uo pipefail

PKG=com.sk.keeper
ACT=$PKG/.MainActivity
STATE=/data/local/tmp/.sk/state
ADB=${ADB:-adb}
APK=""
FRESH=0
NOINSTALL=0
for a in "$@"; do
  case "$a" in
    --fresh) FRESH=1 ;;
    --no-install) NOINSTALL=1 ;;
    *) APK="$a" ;;
  esac
done
APK=${APK:-dist/Keeper_legacy_unsigned-aligned-debugSigned.apk}

PASS=0; FAIL=0
ok(){ PASS=$((PASS+1)); printf '  [PASS] %s\n' "$*"; }
bad(){ FAIL=$((FAIL+1)); printf '  [FAIL] %s\n' "$*"; }
say(){ printf '\n== %s ==\n' "$*"; }

command -v "$ADB" >/dev/null 2>&1 || { echo "找不到 adb: $ADB" >&2; exit 1; }
"$ADB" get-state >/dev/null 2>&1 || { echo "没有设备：adb devices 为空" >&2; exit 1; }

say "设备"
"$ADB" shell getprop ro.product.model 2>/dev/null | sed 's/^/  model: /'
"$ADB" shell getprop ro.build.version.release 2>/dev/null | sed 's/^/  android: /'

if [ "$NOINSTALL" = 0 ]; then
  say "安装"
  OUT=$("$ADB" install -r -g "$APK" 2>&1)
  echo "$OUT" | sed 's/^/  /'
  if echo "$OUT" | grep -q "Success"; then
    ok "install"
  elif echo "$OUT" | grep -q "INSTALL_FAILED_UPDATE_INCOMPATIBLE" && [ "$FRESH" = 1 ]; then
    "$ADB" uninstall "$PKG" >/dev/null 2>&1
    OUT=$("$ADB" install -g "$APK" 2>&1)
    echo "$OUT" | sed 's/^/  /'
    echo "$OUT" | grep -q "Success" && ok "install (fresh)" || bad "install (fresh)"
  else
    bad "install: $OUT"
    echo "  签名不一致时加 --fresh（会清数据）" >&2
    exit 1
  fi
else
  say "安装（跳过）"
fi

say "启动"
"$ADB" shell am start -n "$ACT" >/dev/null 2>&1
sleep 6

say "载荷"
PIDS=$("$ADB" shell "for f in $STATE/*.pid; do [ -f \"\$f\" ] && echo \"\$(basename \$f .pid)=\$(cat \$f)\"; done" 2>/dev/null)
echo "$PIDS" | sed 's/^/  /'
HAVE=0
for n in sweep revive guard; do
  if echo "$PIDS" | grep -q "^$n="; then
    p=$(echo "$PIDS" | sed -n "s/^$n=\([0-9]*\).*/\1/p")
    c=$("$ADB" shell "cat /proc/$p/comm 2>/dev/null" | tr -d '\r')
    if [ "$c" = "sk_$n" ]; then ok "payload $n pid=$p"; HAVE=$((HAVE+1));
    else bad "payload $n pid=$p comm=$c"; fi
  else
    bad "payload $n 未运行"
  fi
done
if [ "$HAVE" -lt 3 ]; then
  echo
  echo "载荷没齐（$HAVE/3）。先在 App 里完成无线调试配对/激活，再跑本脚本。" >&2
  "$ADB" logcat -d -s Skeeper 2>/dev/null | tail -20 | sed 's/^/  /'
  exit 2
fi

APP_PID=$("$ADB" shell pidof "$PKG" 2>/dev/null | tr -d '\r')
[ -n "$APP_PID" ] && ok "App pid=$APP_PID" || bad "App 不在运行"
BLOCK0=$("$ADB" shell "cat $STATE/blocked 2>/dev/null || echo 0" | tr -d '\r')
echo "  blocked before = $BLOCK0"

say "攻击 1: detached shell 里 am force-stop"
"$ADB" logcat -c
"$ADB" shell "nohup sh -c 'sleep 1; am force-stop $PKG' >/dev/null 2>&1 &" >/dev/null 2>&1
sleep 4
APP_PID2=$("$ADB" shell pidof "$PKG" 2>/dev/null | tr -d '\r')
BLOCK1=$("$ADB" shell "cat $STATE/blocked 2>/dev/null || echo 0" | tr -d '\r')
echo "  app pid: $APP_PID -> $APP_PID2 | blocked: $BLOCK0 -> $BLOCK1"
if [ -n "$APP_PID2" ] && [ "$APP_PID2" = "$APP_PID" ]; then
  ok "App 没被停（同一个 pid）"
else
  bad "App 被 stopped（pid 变了或为空）"
fi
if [ "${BLOCK1:-0}" -gt "${BLOCK0:-0}" ] 2>/dev/null; then ok "guard 计数增加"; else bad "guard 计数没变"; fi
"$ADB" logcat -d -s Skeeper 2>/dev/null | grep -E "guard:|拦截" | tail -6 | sed 's/^/  /'

say "攻击 2: detached shell 里 pm disable-user"
B2=$("$ADB" shell "cat $STATE/blocked 2>/dev/null || echo 0" | tr -d '\r')
"$ADB" shell "nohup sh -c 'sleep 1; pm disable-user --user 0 $PKG' >/dev/null 2>&1 &" >/dev/null 2>&1
sleep 4
DIS=$("$ADB" shell "pm list packages -d | grep -x package:$PKG" 2>/dev/null | tr -d '\r')
B3=$("$ADB" shell "cat $STATE/blocked 2>/dev/null || echo 0" | tr -d '\r')
if [ -z "$DIS" ]; then ok "包没被 disable"; else bad "包被 disable 了"; fi
if [ "${B3:-0}" -gt "${B2:-0}" ] 2>/dev/null; then ok "guard 计数增加"; else bad "guard 计数没变"; fi
"$ADB" logcat -d -s Skeeper 2>/dev/null | grep -E "guard:|拦截" | tail -6 | sed 's/^/  /'

say "状态"
"$ADB" shell "echo hits=\$(cat $STATE/hits 2>/dev/null); echo blocked=\$(cat $STATE/blocked 2>/dev/null); echo last=\$(cat $STATE/blocked_last 2>/dev/null)" 2>/dev/null | sed 's/^/  /'
"$ADB" shell "cat $STATE/log 2>/dev/null | tail -12" | sed 's/^/  /'

printf '\n结果: %d passed, %d failed\n' "$PASS" "$FAIL"
[ "$FAIL" -eq 0 ] || exit 1
