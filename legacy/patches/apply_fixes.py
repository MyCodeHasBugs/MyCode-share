#!/usr/bin/env python3
"""旧版 Keeper 的本轮 smali 补丁（4 项），在 apktool 反编译目录上就地修改。

用法:
    python apply_fixes.py <apktool_dec_dir> <shrun_binary>

四项:
  1. shrun 接线    —— 部署时从 assets 释放 /data/local/tmp/.sk/shrun
  2. 二次激活      —— 旧 endpoint 直连失败就清缓存,避免一直拿死端口重试
  3. 覆盖系统界面  —— 用 sk_revive 自带的 state/no_pull 开关,配对期间不抢前台
  4. 紧急退出      —— 清场时一并删掉 shrun / .h / no_pull 残留

所有替换都带锚点次数断言,锚点对不上直接失败,不静默跳过。
"""
import pathlib
import shutil
import sys

DEC = pathlib.Path(sys.argv[1])
SHRUN = pathlib.Path(sys.argv[2])
PAY = DEC / "smali/com/sk/keeper/Payloads.smali"
MAIN = DEC / "smali/com/sk/keeper/MainActivity.smali"
YML = DEC / "apktool.yml"


def rep(s: str, old: str, new: str, expect: int) -> str:
    n = s.count(old)
    if n != expect:
        raise SystemExit("锚点命中 %d 次,期望 %d: %r" % (n, expect, old[:80]))
    return s.replace(old, new)


for f in (PAY, MAIN, YML, SHRUN):
    if not f.exists():
        raise SystemExit("缺文件: %s" % f)

s = PAY.read_text(encoding="utf-8")

# ---- 3. 覆盖系统界面:初始写 no_pull,禁止 revive 把 App 拉到前台盖住系统设置 ----
s = rep(
    s,
    "chmod 700 /data/local/tmp/.sk; p=$(pm path",
    "chmod 700 /data/local/tmp/.sk; : > /data/local/tmp/.sk/state/no_pull; p=$(pm path",
    1,
)

# 守护循环里按 App 是否存活动态维护:活着就继续禁拉前台,
# 进程没了才放开让 revive 拉起,拉起后下一轮又会自动写回。
s = rep(
    s,
    "while :; do sleep 2; ",
    "while :; do sleep 2; "
    "if pgrep -f com.sk.keeper >/dev/null 2>&1; then "
    ": > /data/local/tmp/.sk/state/no_pull; "
    "else rm -f /data/local/tmp/.sk/state/no_pull; fi; ",
    1,
)

# ---- 4. 紧急退出:清场时删掉匿名守护载体与标记,不留残余 ----
old_kill = ("rm -f /data/local/tmp/.sk/state/hits /data/local/tmp/.sk/state/last "
            "/data/local/tmp/.sk/state/*.pid 2>/dev/null; true")
new_kill = ("rm -f /data/local/tmp/.sk/shrun /data/local/tmp/.sk/.h "
            "/data/local/tmp/.sk/.shrun.new /data/local/tmp/.sk/state/no_pull 2>/dev/null; "
            + old_kill)
n = s.count(old_kill)
if n < 2:
    raise SystemExit("清场脚本锚点只命中 %d 次(应至少 2: deploy + emergency)" % n)
s = s.replace(old_kill, new_kill)

# ---- 1. shrun 接线:照 boot 的 asset()->execIn() 路子把二进制写到 shell 可写目录 ----
anchor = '    :cond_1\n    const-string v2, "\\u53ef\\u6267\\u884c  "'
shrun_smali = '''    const-string v2, "sk/shrun"

    invoke-static {p0, v2}, Lcom/sk/keeper/Payloads;->asset(Landroid/content/Context;Ljava/lang/String;)[B

    move-result-object v2

    const-string v6, "cat > /data/local/tmp/.sk/.shrun.new"

    invoke-interface {p1, v6, v2}, Lcom/sk/keeper/Shell;->execIn(Ljava/lang/String;[B)Ljava/lang/String;

    const-string v6, "mv -f /data/local/tmp/.sk/.shrun.new /data/local/tmp/.sk/shrun && chmod 755 /data/local/tmp/.sk/shrun"

    invoke-interface {p1, v6}, Lcom/sk/keeper/Shell;->exec(Ljava/lang/String;)Ljava/lang/String;

'''
s = rep(
    s,
    anchor,
    "    :cond_1\n" + shrun_smali + '    const-string v2, "\\u53ef\\u6267\\u884c  "',
    1,
)

# ---- 6. 提速:守护循环 2s -> 0.5s,装完等 key 恢复 1s -> 0.3s ----
# toybox 的 sleep 支持小数秒;万一某个 ROM 不支持,循环会空转,那时改回整数。
s = rep(s, "while :; do sleep 2; ", "while :; do sleep 0.5; ", 1)
s = rep(s, "sleep 1; run-as", "sleep 0.3; run-as", 1)
PAY.write_text(s, encoding="utf-8")

# ---- 2. 二次激活:connect 不含 connected 时清掉过期的 endpoint 缓存 ----
m = MAIN.read_text(encoding="utf-8")
clear_ep = '''    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v5

    invoke-interface {v5}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v5

    const-string v6, "endpoint"

    invoke-interface {v5, v6}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v5}, Landroid/content/SharedPreferences$Editor;->apply()V

'''
m = rep(m, "    .line 401\n    return v3", clear_ep + "    .line 401\n    return v3", 1)

# ---- 5. onCreate 里通知权限判断写反了 ----
# checkSelfPermission: 0=已授权, -1=未授权。原来写的 if-nez(非0就跳过),
# 导致「没授权时跳过申请、已授权时反而申请」,打开 App 永远看不到权限弹窗。
# 改成 if-eqz(已授权才跳过)。基线 smali 可能已修过,所以两种状态都接受。
bad = "    if-nez v0, :cond_notif_perm"
good = "    if-eqz v0, :cond_notif_perm"
if bad in m:
    m = rep(m, bad, good, 1)
    print("  修正 onCreate 通知权限判断: if-nez -> if-eqz")
elif good in m:
    print("  onCreate 通知权限判断已是正确版,跳过")
else:
    raise SystemExit("通知权限补丁锚点丢失(错误版和正确版都没找到)")

# ---- 7. 提速:UI 状态轮询 1s / 2s 统一压到 0.5s ----
m = rep(m, "    const-wide/16 v2, 0x3e8", "    const-wide/16 v2, 0x1f4", 1)
m = rep(m, "    const-wide/16 v5, 0x7d0", "    const-wide/16 v5, 0x1f4", 1)

# ---- 8. 配对前强制重启 adb server ----
# 借 Shizuku starter 的做法:起新进程之前先把旧的清掉。
# 上一轮配对失败留下的 server 状态不干净时,client 会在读 status 应答阶段
# 被关连接,表现就是 protocol fault (couldn't read status message)。
old_pair = ('    .line 969\n'
            '    invoke-virtual {v1, v2, p1}, Lcom/sk/keeper/AdbCli;->pair'
            '(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;')
new_pair = ('    invoke-virtual {v1}, Lcom/sk/keeper/AdbCli;->killServer()V\n'
            '\n'
            '    invoke-virtual {v1}, Lcom/sk/keeper/AdbCli;->startServer()Z\n'
            '\n'
            '    .line 969\n'
            '    invoke-virtual {v1, v2, p1}, Lcom/sk/keeper/AdbCli;->pair'
            '(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;')
m = rep(m, old_pair, new_pair, 1)

MAIN.write_text(m, encoding="utf-8")

# ---- assets + apktool.yml(doNotCompress 要包含新二进制) ----
dst = DEC / "assets/sk/shrun"
dst.parent.mkdir(parents=True, exist_ok=True)
shutil.copyfile(SHRUN, dst)

y = YML.read_text(encoding="utf-8")
if "- assets/sk/shrun" not in y:
    y = rep(y, "- assets/sk/sk_sweep.so",
            "- assets/sk/sk_sweep.so\n- assets/sk/shrun", 1)
    YML.write_text(y, encoding="utf-8")

print("补丁完成: 4 项全部应用")
