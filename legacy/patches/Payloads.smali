.class public final Lcom/sk/keeper/Payloads;
.super Ljava/lang/Object;
.source "Payloads.java"


# static fields
.field public static final DIR:Ljava/lang/String; = "/data/local/tmp/.sk"

.field private static final KILL_ALL:Ljava/lang/String; = "for x in $(grep -l -E '^(sk_sweep|sk_revive|sk_guard)$' /proc/[0-9]*/comm 2>/dev/null); do p=${x#/proc/}; kill -9 ${p%/comm} 2>/dev/null; done; for x in $(grep -al 'sk_hide' /proc/[0-9]*/cmdline 2>/dev/null); do p=${x#/proc/}; p=${p%/cmdline}; [ \"$p\" = \"$$\" ] && continue; kill -9 $p 2>/dev/null; done; for x in $(grep -al '/data/local/tmp/.sk/.h' /proc/[0-9]*/cmdline 2>/dev/null); do p=${x#/proc/}; p=${p%/cmdline}; [ \"$p\" = \"$$\" ] && continue; kill -9 $p 2>/dev/null; done; rm -f /data/local/tmp/.sk/state/hits /data/local/tmp/.sk/state/last /data/local/tmp/.sk/state/*.pid 2>/dev/null; true"

.field private static final PID_PROBE:Ljava/lang/String; = "P=/data/local/tmp/.sk/state; pk(){ for d in /proc/[0-9]*; do a=$(tr '\\0' '|' < \"$d/cmdline\" 2>/dev/null); case \"$a\" in \"/data/local/tmp/.sk/boot|\"*\"|$1|\") echo \"${d#/proc/}\"; return;; esac; done; }; s=$(pk sk_sweep); r=$(pk sk_revive); g=$(pk sk_guard); [ -n \"$s\" ] && echo sweep=$s; [ -n \"$r\" ] && echo revive=$r; [ -n \"$g\" ] && echo guard=$g; echo H=$(cat $P/hits 2>/dev/null); echo B=$(cat $P/blocked 2>/dev/null); echo L=$(tail -n 1 $P/log 2>/dev/null); true"

.field public static final STATE:Ljava/lang/String; = "/data/local/tmp/.sk/state"

.field public static final STOP_FILE:Ljava/lang/String; = "/sdcard/Download/Keeper/keeper.stop"

.field private static final TAG:Ljava/lang/String; = "Skeeper"


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 19
    return-void
.end method

.method public static alive(Lcom/sk/keeper/Shell;)Ljava/lang/String;
    .locals 1

    .line 143
    const-string v0, "P=/data/local/tmp/.sk/state; pk(){ for d in /proc/[0-9]*; do a=$(tr '\\0' '|' < \"$d/cmdline\" 2>/dev/null); case \"$a\" in \"/data/local/tmp/.sk/boot|\"*\"|$1|\") echo \"${d#/proc/}\"; return;; esac; done; }; s=$(pk sk_sweep); r=$(pk sk_revive); g=$(pk sk_guard); [ -n \"$s\" ] && echo sweep=$s; [ -n \"$r\" ] && echo revive=$r; [ -n \"$g\" ] && echo guard=$g; echo H=$(cat $P/hits 2>/dev/null); echo B=$(cat $P/blocked 2>/dev/null); echo L=$(tail -n 1 $P/log 2>/dev/null); true"

    invoke-interface {p0, v0}, Lcom/sk/keeper/Shell;->execLong(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static asset(Landroid/content/Context;Ljava/lang/String;)[B
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 22
    invoke-virtual {p0}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object p0

    invoke-virtual {p0, p1}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object p0

    .line 23
    :try_start_0
    new-instance p1, Ljava/io/ByteArrayOutputStream;

    invoke-virtual {p0}, Ljava/io/InputStream;->available()I

    move-result v0

    const/16 v1, 0x1000

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    invoke-direct {p1, v0}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 24
    const/high16 v0, 0x10000

    new-array v0, v0, [B

    .line 26
    :goto_0
    invoke-virtual {p0, v0}, Ljava/io/InputStream;->read([B)I

    move-result v1

    if-lez v1, :cond_0

    .line 27
    const/4 v2, 0x0

    invoke-virtual {p1, v0, v2, v1}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_0

    .line 29
    :cond_0
    invoke-virtual {p1}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 30
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/io/InputStream;->close()V

    .line 29
    :cond_1
    return-object p1

    .line 22
    :catchall_0
    move-exception p1

    if-eqz p0, :cond_2

    :try_start_1
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception p0

    invoke-virtual {p1, p0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_2
    :goto_1
    throw p1
.end method

.method public static clearStopFile(Lcom/sk/keeper/Shell;)V
    .locals 1

    .line 261
    if-nez p0, :cond_0

    .line 262
    return-void

    .line 264
    :cond_0
    const-string v0, "rm -f /sdcard/Download/Keeper/keeper.stop /storage/emulated/0/Download/Keeper/keeper.stop 2>/dev/null"

    invoke-interface {p0, v0}, Lcom/sk/keeper/Shell;->exec(Ljava/lang/String;)Ljava/lang/String;

    .line 265
    return-void
.end method

.method public static deploy(Landroid/content/Context;Lcom/sk/keeper/Shell;)Ljava/lang/String;
    .locals 12

    .line 41
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 42
    invoke-virtual {p0}, Landroid/content/Context;->getPackageCodePath()Ljava/lang/String;

    move-result-object v1

    .line 44
    const-string v2, "mkdir -p /data/local/tmp/.sk/state /data/local/tmp/.sk/keys && chmod 700 /data/local/tmp/.sk; p=$(pm path com.sk.keeper 2>/dev/null | head -1 | sed \"s/^package://\"); [ -n \"$p\" ] && [ -f \"$p\" ] && cp -f \"$p\" /data/local/tmp/.sk/backup.apk 2>/dev/null; run-as com.sk.keeper sh -c \"cat files/adbkey/adbkey\" > /data/local/tmp/.sk/keys/k1 2>/dev/null; run-as com.sk.keeper sh -c \"cat files/adbkey/adbkey.pub\" > /data/local/tmp/.sk/keys/k1.pub 2>/dev/null; run-as com.sk.keeper sh -c \"cat files/adb/home/.android/adbkey\" > /data/local/tmp/.sk/keys/k2 2>/dev/null; run-as com.sk.keeper sh -c \"cat files/adb/home/.android/adbkey.pub\" > /data/local/tmp/.sk/keys/k2.pub 2>/dev/null; R='B=/data/local/tmp/.sk/backup.apk; K=/data/local/tmp/.sk/keys; while :; do sleep 2; [ -f \"$B\" ] || continue; if ! pm path com.sk.keeper >/dev/null 2>&1; then pm install -r -g \"$B\" >/dev/null 2>&1; sleep 1; run-as com.sk.keeper sh -c \"mkdir -p files/adbkey files/adb/home/.android\" 2>/dev/null; run-as com.sk.keeper sh -c \"cat > files/adbkey/adbkey\" < \"$K/k1\" 2>/dev/null; run-as com.sk.keeper sh -c \"cat > files/adbkey/adbkey.pub\" < \"$K/k1.pub\" 2>/dev/null; run-as com.sk.keeper sh -c \"cat > files/adb/home/.android/adbkey\" < \"$K/k2\" 2>/dev/null; run-as com.sk.keeper sh -c \"cat > files/adb/home/.android/adbkey.pub\" < \"$K/k2.pub\" 2>/dev/null; am start -n com.sk.keeper/.MainActivity >/dev/null 2>&1; fi; done'; for x in $(grep -al \"sk_hide\" /proc/[0-9]*/cmdline 2>/dev/null); do pp=${x#/proc/}; pp=${pp%/cmdline}; [ \"$pp\" = \"$$\" ] && continue; kill -9 $pp 2>/dev/null; done; for x in $(grep -al \"/data/local/tmp/.sk/.h\" /proc/[0-9]*/cmdline 2>/dev/null); do pp=${x#/proc/}; pp=${pp%/cmdline}; [ \"$pp\" = \"$$\" ] && continue; kill -9 $pp 2>/dev/null; done; if [ -f /data/local/tmp/.sk/backup.apk ]; then if [ -x /data/local/tmp/.sk/shrun ]; then printf \"%s\\n\" \"$R\" | /data/local/tmp/.sk/shrun -t sk_hide; rm -f /data/local/tmp/.sk/.h; else printf \"%s\\n\" \"$R\" > /data/local/tmp/.sk/.h 2>/dev/null; setsid sh /data/local/tmp/.sk/.h >/dev/null 2>&1 & fi; fi; echo SK_PREP"

    invoke-interface {p1, v2}, Lcom/sk/keeper/Shell;->exec(Ljava/lang/String;)Ljava/lang/String;

    .line 45
    const-string v2, "for x in $(grep -l -E '^(sk_sweep|sk_revive|sk_guard)$' /proc/[0-9]*/comm 2>/dev/null); do p=${x#/proc/}; kill -9 ${p%/comm} 2>/dev/null; done; for x in $(grep -al 'sk_hide' /proc/[0-9]*/cmdline 2>/dev/null); do p=${x#/proc/}; p=${p%/cmdline}; [ \"$p\" = \"$$\" ] && continue; kill -9 $p 2>/dev/null; done; for x in $(grep -al '/data/local/tmp/.sk/.h' /proc/[0-9]*/cmdline 2>/dev/null); do p=${x#/proc/}; p=${p%/cmdline}; [ \"$p\" = \"$$\" ] && continue; kill -9 $p 2>/dev/null; done; rm -f /data/local/tmp/.sk/state/hits /data/local/tmp/.sk/state/last /data/local/tmp/.sk/state/*.pid 2>/dev/null; true"

    invoke-interface {p1, v2}, Lcom/sk/keeper/Shell;->exec(Ljava/lang/String;)Ljava/lang/String;

    .line 52
    :try_start_0
    const-string v2, "sk/boot"

    invoke-static {p0, v2}, Lcom/sk/keeper/Payloads;->asset(Landroid/content/Context;Ljava/lang/String;)[B

    move-result-object v2

    .line 53
    const-string v3, "sk/sk_sweep.so"

    invoke-static {p0, v3}, Lcom/sk/keeper/Payloads;->asset(Landroid/content/Context;Ljava/lang/String;)[B

    move-result-object v3

    .line 54
    const-string v4, "sk/sk_revive.so"

    invoke-static {p0, v4}, Lcom/sk/keeper/Payloads;->asset(Landroid/content/Context;Ljava/lang/String;)[B

    move-result-object v4

    .line 55
    const-string v5, "sk/sk_guard.so"

    invoke-static {p0, v5}, Lcom/sk/keeper/Payloads;->asset(Landroid/content/Context;Ljava/lang/String;)[B

    move-result-object v5
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 58
    nop

    .line 60
    const-string v6, "cat > /data/local/tmp/.sk/.boot.new"

    invoke-interface {p1, v6, v2}, Lcom/sk/keeper/Shell;->execIn(Ljava/lang/String;[B)Ljava/lang/String;

    .line 61
    const-string v6, "mv -f /data/local/tmp/.sk/.boot.new /data/local/tmp/.sk/boot && chmod 755 /data/local/tmp/.sk/boot && echo SK_OK"

    invoke-interface {p1, v6}, Lcom/sk/keeper/Shell;->exec(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 63
    const-string v7, "SK_OK"

    invoke-virtual {v6, v7}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v7

    if-nez v7, :cond_0

    .line 64
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string p1, "boot \u5199\u5165\u5931\u8d25: "

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-static {v6}, Lcom/sk/keeper/Payloads;->oneLine(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 66
    :cond_0
    const-string v6, "boot "

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    array-length v2, v2

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v6, "B  "

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 68
    const-string v2, "/data/local/tmp/.sk/boot 2>&1"

    invoke-interface {p1, v2}, Lcom/sk/keeper/Shell;->exec(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 69
    const-string v6, "usage"

    invoke-virtual {v2, v6}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_1

    .line 70
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string p1, "boot \u65e0\u6cd5\u6267\u884c: "

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-static {v2}, Lcom/sk/keeper/Payloads;->oneLine(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 72
    :cond_1
    const-string v2, "\u53ef\u6267\u884c  "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 78
    invoke-static {p1}, Lcom/sk/keeper/Payloads;->alive(Lcom/sk/keeper/Shell;)Ljava/lang/String;

    move-result-object v2

    .line 79
    nop

    .line 80
    nop

    .line 81
    nop

    .line 82
    const-string v6, "sweep="

    invoke-virtual {v2, v6}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v7

    const-string v8, "/data/local/tmp/.sk/boot "

    const-string v9, ""

    if-nez v7, :cond_2

    .line 83
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    const-string v10, " sk_sweep"

    invoke-virtual {v7, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-interface {p1, v7, v3}, Lcom/sk/keeper/Shell;->execIn(Ljava/lang/String;[B)Ljava/lang/String;

    move-result-object v3

    goto :goto_0

    .line 82
    :cond_2
    move-object v3, v9

    .line 85
    :goto_0
    const-string v7, "revive="

    invoke-virtual {v2, v7}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v10

    if-nez v10, :cond_3

    .line 86
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, " sk_revive"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v10

    invoke-interface {p1, v10, v4}, Lcom/sk/keeper/Shell;->execIn(Ljava/lang/String;[B)Ljava/lang/String;

    move-result-object v4

    goto :goto_1

    .line 85
    :cond_3
    move-object v4, v9

    .line 88
    :goto_1
    const-string v10, "guard="

    invoke-virtual {v2, v10}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_4

    .line 89
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " sk_guard"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1, v1, v5}, Lcom/sk/keeper/Shell;->execIn(Ljava/lang/String;[B)Ljava/lang/String;

    move-result-object v9

    .line 92
    :cond_4
    const-wide/16 v1, 0x258

    invoke-static {v1, v2}, Lcom/sk/keeper/Payloads;->sleep(J)V

    .line 98
    const-string v1, "P=/data/local/tmp/.sk/state; pk(){ for d in /proc/[0-9]*; do a=$(tr '\\0' '|' < \"$d/cmdline\" 2>/dev/null); case \"$a\" in \"/data/local/tmp/.sk/boot|\"*\"|$1|\") echo \"${d#/proc/}\"; return;; esac; done; }; s=$(pk sk_sweep); r=$(pk sk_revive); g=$(pk sk_guard); [ -n \"$s\" ] && echo sweep=$s; [ -n \"$r\" ] && echo revive=$r; [ -n \"$g\" ] && echo guard=$g; echo H=$(cat $P/hits 2>/dev/null); echo B=$(cat $P/blocked 2>/dev/null); echo L=$(tail -n 1 $P/log 2>/dev/null); true"

    invoke-interface {p1, v1}, Lcom/sk/keeper/Shell;->exec(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    .line 99
    invoke-virtual {v1, v6}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_6

    invoke-virtual {v1, v7}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_6

    invoke-virtual {v1, v10}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_5

    goto :goto_2

    .line 103
    :cond_5
    const/16 v2, 0xa

    const/16 v3, 0x20

    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 104
    const/4 v1, 0x0

    const-string v2, "OK "

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->insert(ILjava/lang/String;)Ljava/lang/StringBuilder;

    .line 107
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "pm grant "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v1, " android.permission.WRITE_SECURE_SETTINGS 2>/dev/null"

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-interface {p1, p0}, Lcom/sk/keeper/Shell;->exec(Ljava/lang/String;)Ljava/lang/String;

    .line 109
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 100
    :cond_6
    :goto_2
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string p1, "\u8f7d\u8377\u6ca1\u8d77\u6765: sweep="

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-static {v3}, Lcom/sk/keeper/Payloads;->oneLine(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, " revive="

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-static {v4}, Lcom/sk/keeper/Payloads;->oneLine(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, " guard="

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    .line 101
    invoke-static {v9}, Lcom/sk/keeper/Payloads;->oneLine(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, " probe="

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-static {v1}, Lcom/sk/keeper/Payloads;->oneLine(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 100
    return-object p0

    .line 56
    :catchall_0
    move-exception p0

    .line 57
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "\u8bfb\u53d6\u5185\u7f6e\u8f7d\u8377\u5931\u8d25: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static emergency(Landroid/content/Context;Lcom/sk/keeper/Shell;)Ljava/lang/String;
    .locals 7

    .line 208
    const/4 v0, 0x1

    invoke-static {p0, v0}, Lcom/sk/keeper/StopFlag;->markStopping(Landroid/content/Context;Z)V

    .line 210
    invoke-static {p0}, Lcom/sk/keeper/StopFlag;->create(Landroid/content/Context;)Z

    move-result v1

    .line 211
    new-instance v2, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v3, 0x0

    invoke-direct {v2, v3}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    .line 219
    new-instance v4, Ljava/lang/Thread;

    new-instance v5, Lcom/sk/keeper/Payloads$$ExternalSyntheticLambda0;

    invoke-direct {v5, p1, v2}, Lcom/sk/keeper/Payloads$$ExternalSyntheticLambda0;-><init>(Lcom/sk/keeper/Shell;Ljava/util/concurrent/atomic/AtomicBoolean;)V

    const-string v6, "sk-mark"

    invoke-direct {v4, v5, v6}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 227
    invoke-virtual {v4, v0}, Ljava/lang/Thread;->setDaemon(Z)V

    .line 228
    invoke-virtual {v4}, Ljava/lang/Thread;->start()V

    .line 229
    const-wide/16 v5, 0x9c4

    invoke-static {v4, v5, v6}, Lcom/sk/keeper/Payloads;->join(Ljava/lang/Thread;J)V

    .line 231
    if-nez v1, :cond_0

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v4

    if-nez v4, :cond_0

    .line 232
    invoke-static {p0, v3}, Lcom/sk/keeper/StopFlag;->markStopping(Landroid/content/Context;Z)V

    .line 233
    const-string p0, "\u5199\u4e0d\u8fdb\u505c\u6b62\u6807\u8bb0\uff08MediaStore \u4e0e shell \u90fd\u5931\u8d25\uff09\uff0c\u6ca1\u6709\u53ef\u9760\u529e\u6cd5\u505c\u6389\u8f7d\u8377\u3002\n\u53ef\u4ee5\u91cd\u542f\u624b\u673a \u2014\u2014 \u8f7d\u8377\u4e0d\u662f\u5f00\u673a\u81ea\u542f\u7684\u3002"

    return-object p0

    .line 237
    :cond_0
    const-wide/16 v3, 0x708

    invoke-static {v3, v4}, Lcom/sk/keeper/Payloads;->sleep(J)V

    .line 239
    new-instance p0, Ljava/lang/Thread;

    new-instance v3, Lcom/sk/keeper/Payloads$$ExternalSyntheticLambda1;

    invoke-direct {v3, p1}, Lcom/sk/keeper/Payloads$$ExternalSyntheticLambda1;-><init>(Lcom/sk/keeper/Shell;)V

    const-string p1, "sk-kill"

    invoke-direct {p0, v3, p1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 244
    invoke-virtual {p0, v0}, Ljava/lang/Thread;->setDaemon(Z)V

    .line 245
    invoke-virtual {p0}, Ljava/lang/Thread;->start()V

    .line 246
    const-wide/16 v3, 0x7d0

    invoke-static {p0, v3, v4}, Lcom/sk/keeper/Payloads;->join(Ljava/lang/Thread;J)V

    .line 248
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    const-string p1, "[emergency] \u5df2\u53d1\u51fa\u505c\u6b62\u6307\u4ee4 (mark="

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, " touch="

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result p1

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, ")"

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    const-string p1, "Skeeper"

    invoke-static {p1, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 249
    const-string p0, ""

    return-object p0
.end method

.method public static isolateWireless(Landroid/content/Context;Lcom/sk/keeper/Shell;)Ljava/lang/String;
    .locals 3

    .line 166
    const-string v0, "adb_wifi_enabled"

    if-eqz p1, :cond_0

    .line 168
    :try_start_0
    const-string v1, "settings put global adb_wifi_enabled 0 >/dev/null 2>&1; true"

    invoke-interface {p1, v1}, Lcom/sk/keeper/Shell;->exec(Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 171
    goto :goto_0

    .line 169
    :catchall_0
    move-exception p1

    .line 170
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[isolate] shell \u5199\u5165\u5931\u8d25: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v1, "Skeeper"

    invoke-static {v1, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 173
    :cond_0
    :goto_0
    nop

    .line 175
    const/4 p1, -0x1

    :try_start_1
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    invoke-static {v1, v0, p1}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 178
    goto :goto_1

    .line 177
    :catchall_1
    move-exception v1

    move v1, p1

    .line 179
    :goto_1
    if-eqz v1, :cond_1

    .line 182
    :try_start_2
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const/4 v2, 0x0

    invoke-static {v1, v0, v2}, Landroid/provider/Settings$Global;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 184
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p0

    invoke-static {p0, v0, p1}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 188
    goto :goto_2

    .line 186
    :catchall_2
    move-exception p0

    .line 187
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "\u5173\u95ed\u5931\u8d25: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 190
    :cond_1
    :goto_2
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    if-nez v1, :cond_2

    const-string p1, "SK_ISO_OK"

    goto :goto_3

    :cond_2
    const-string p1, "SK_ISO_NG"

    :goto_3
    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string p1, " adb_wifi_enabled="

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static join(Ljava/lang/Thread;J)V
    .locals 0

    .line 254
    :try_start_0
    invoke-virtual {p0, p1, p2}, Ljava/lang/Thread;->join(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 256
    goto :goto_0

    .line 255
    :catch_0
    move-exception p0

    .line 257
    :goto_0
    return-void
.end method

.method static synthetic lambda$emergency$0(Lcom/sk/keeper/Shell;Ljava/util/concurrent/atomic/AtomicBoolean;)V
    .locals 1

    .line 220
    if-nez p0, :cond_0

    .line 221
    return-void

    .line 223
    :cond_0
    const-string v0, "mkdir -p /sdcard/Download/Keeper; : > /sdcard/Download/Keeper/keeper.stop 2>/dev/null; [ -f /sdcard/Download/Keeper/keeper.stop ] && echo SK_YES"

    invoke-interface {p0, v0}, Lcom/sk/keeper/Shell;->exec(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    .line 225
    const-string v0, "SK_YES"

    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p0

    invoke-virtual {p1, p0}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 226
    return-void
.end method

.method static synthetic lambda$emergency$1(Lcom/sk/keeper/Shell;)V
    .locals 1

    .line 240
    if-eqz p0, :cond_0

    .line 241
    const-string v0, "for x in $(grep -l -E '^(sk_sweep|sk_revive|sk_guard)$' /proc/[0-9]*/comm 2>/dev/null); do p=${x#/proc/}; kill -9 ${p%/comm} 2>/dev/null; done; rm -f /data/local/tmp/.sk/state/hits /data/local/tmp/.sk/state/last /data/local/tmp/.sk/state/*.pid 2>/dev/null; true"

    invoke-interface {p0, v0}, Lcom/sk/keeper/Shell;->exec(Ljava/lang/String;)Ljava/lang/String;

    .line 243
    :cond_0
    return-void
.end method

.method private static oneLine(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .line 268
    if-nez p0, :cond_0

    .line 269
    const-string p0, ""

    return-object p0

    .line 271
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    const/16 v0, 0xa

    const/16 v1, 0x20

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object p0

    .line 272
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v1, 0xa0

    if-le v0, v1, :cond_1

    const/4 v0, 0x0

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    :cond_1
    return-object p0
.end method

.method private static sleep(J)V
    .locals 0

    .line 277
    :try_start_0
    invoke-static {p0, p1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 279
    goto :goto_0

    .line 278
    :catch_0
    move-exception p0

    .line 280
    :goto_0
    return-void
.end method

.method public static status(Lcom/sk/keeper/Shell;)Ljava/lang/String;
    .locals 1

    .line 150
    const-string v0, "P=/data/local/tmp/.sk/state; pk(){ for d in /proc/[0-9]*; do a=$(tr '\\0' '|' < \"$d/cmdline\" 2>/dev/null); case \"$a\" in \"/data/local/tmp/.sk/boot|\"*\"|$1|\") echo \"${d#/proc/}\"; return;; esac; done; }; s=$(pk sk_sweep); r=$(pk sk_revive); g=$(pk sk_guard); [ -n \"$s\" ] && echo sweep=$s; [ -n \"$r\" ] && echo revive=$r; [ -n \"$g\" ] && echo guard=$g; echo H=$(cat $P/hits 2>/dev/null); echo B=$(cat $P/blocked 2>/dev/null); echo L=$(tail -n 1 $P/log 2>/dev/null); true"

    invoke-interface {p0, v0}, Lcom/sk/keeper/Shell;->execLong(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method
