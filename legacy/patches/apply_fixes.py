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

# 拦截弹窗用的 Runnable:后台轮询线程不能直接 show AlertDialog,
# 必须 post 回 UI 线程,否则抛 "Can't create handler inside thread ..."。
BLOCKED_DIALOG_SMALI = r'''.class final Lcom/sk/keeper/MainActivity$BlockedDialog;
.super Ljava/lang/Object;
.implements Ljava/lang/Runnable;


.field private final activity:Lcom/sk/keeper/MainActivity;

.field private final text:Ljava/lang/String;


.method constructor <init>(Lcom/sk/keeper/MainActivity;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/sk/keeper/MainActivity$BlockedDialog;->activity:Lcom/sk/keeper/MainActivity;

    iput-object p2, p0, Lcom/sk/keeper/MainActivity$BlockedDialog;->text:Ljava/lang/String;

    return-void
.end method


.method public run()V
    .locals 5

    :try_start_0
    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-object v1, p0, Lcom/sk/keeper/MainActivity$BlockedDialog;->activity:Lcom/sk/keeper/MainActivity;

    invoke-direct {v0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const-string v1, "\u26a0 Keeper \u5df2\u963b\u6b62\u6b64\u5a01\u80c1"

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "\u68c0\u6d4b\u5230\u9488\u5bf9 Keeper \u7684\u547d\u4ee4,\u6267\u884c\u8fdb\u7a0b\u5df2\u88ab\u7ec8\u6b62\u3002\n\n\u547d\u4ee4\u4e0e\u6765\u6e90:\n"

    iget-object v2, p0, Lcom/sk/keeper/MainActivity$BlockedDialog;->text:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    const-string v1, "\u597d\u7684"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-void

    :catchall_0
    move-exception v0

    return-void
.end method
'''
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

# ---- 9. 拦截弹窗:读 sk_guard 写的 state/blocked_last,内容变了就弹 ----
m = rep(
    m,
    ".field private hint:Landroid/widget/TextView;",
    ".field private hint:Landroid/widget/TextView;\n"
    "\n"
    "# 上一次弹过的拦截记录,避免同一条反复弹\n"
    ".field private lastBlocked:Ljava/lang/String;",
    1,
)

old_poll = ('    .line 487\n'
            '    :cond_0\n'
            '    iget-object v8, p0, Lcom/sk/keeper/MainActivity;->shell:Lcom/sk/keeper/Shell;\n'
            '\n'
            '    invoke-static {v8}, Lcom/sk/keeper/Payloads;->status(Lcom/sk/keeper/Shell;)Ljava/lang/String;')
new_poll = '''    .line 487
    :cond_0
    iget-object v9, p0, Lcom/sk/keeper/MainActivity;->shell:Lcom/sk/keeper/Shell;

    const-string v10, "cat /data/local/tmp/.sk/state/blocked_last 2>/dev/null"

    invoke-interface {v9, v10}, Lcom/sk/keeper/Shell;->exec(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/String;->isEmpty()Z

    move-result v10

    if-nez v10, :cond_blocked

    iget-object v10, p0, Lcom/sk/keeper/MainActivity;->lastBlocked:Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-nez v10, :cond_blocked

    iput-object v9, p0, Lcom/sk/keeper/MainActivity;->lastBlocked:Ljava/lang/String;

    new-instance v10, Lcom/sk/keeper/MainActivity$BlockedDialog;

    invoke-direct {v10, p0, v9}, Lcom/sk/keeper/MainActivity$BlockedDialog;-><init>(Lcom/sk/keeper/MainActivity;Ljava/lang/String;)V

    iget-object v9, p0, Lcom/sk/keeper/MainActivity;->ui:Landroid/os/Handler;

    invoke-virtual {v9, v10}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :cond_blocked
    iget-object v8, p0, Lcom/sk/keeper/MainActivity;->shell:Lcom/sk/keeper/Shell;

    invoke-static {v8}, Lcom/sk/keeper/Payloads;->status(Lcom/sk/keeper/Shell;)Ljava/lang/String;'''
m = rep(m, old_poll, new_poll, 1)

MAIN.write_text(m, encoding="utf-8")

(DEC / "smali/com/sk/keeper/MainActivity$BlockedDialog.smali").write_text(
    BLOCKED_DIALOG_SMALI, encoding="utf-8")

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
