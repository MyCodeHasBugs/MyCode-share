.class public Lcom/sk/keeper/MainActivity;
.super Landroid/app/Activity;
.source "MainActivity.java"


# static fields
.field private static final ACCENT:I = -0xe93866

.field private static final ACTION_PAIR_REPLY:Ljava/lang/String; = "com.sk.keeper.PAIR_REPLY"

.field private static final BG:I = -0xf7f3ef

.field private static final DANGER:I = -0x1ab7b3

.field private static final DIM:I = -0x907f6f

.field private static final FG:I = -0x170e08

.field private static final KEY_CODE:Ljava/lang/String; = "sk_code"

.field private static final MISS_TOLERANCE:I = 0x4

.field private static final PAIR_CHANNEL:Ljava/lang/String; = "pair_v2"

.field private static final PAIR_NOTI_ID:I = 0x1092

.field private static final PREF:Ljava/lang/String; = "keeper"

.field private static final TAG:Ljava/lang/String; = "Skeeper"

.field private static final WARN:I = -0x1c4cbf


# instance fields
.field private badge:Landroid/widget/TextView;

.field private volatile busy:Z

.field private channelName:Ljava/lang/String;

.field private volatile connectEp:Ljava/lang/String;

.field private exit:Landroid/widget/Button;

.field private volatile flowSeq:I

.field private hint:Landroid/widget/TextView;

.field private isolate:Landroid/widget/Button;

.field private volatile isolated:Z

.field private final lastPids:[Ljava/lang/String;

.field private final missPolls:[I

.field private pairEndpointView:Landroid/widget/EditText;

.field private pairReceiver:Landroid/content/BroadcastReceiver;

.field private volatile pairingEp:Ljava/lang/String;

.field private poller:Ljava/lang/Thread;

.field private volatile running:Z

.field private volatile shell:Lcom/sk/keeper/Shell;

.field private start:Landroid/widget/Button;

.field private status:Landroid/widget/TextView;

.field private final ui:Landroid/os/Handler;

.field private wireless:Lcom/sk/keeper/Wireless;


# direct methods
.method public static synthetic $r8$lambda$75cP5u0DUn3lE6l74yiTmz6YGRg(Lcom/sk/keeper/MainActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->ensureBatteryWhitelist()V

    return-void
.end method

.method public static synthetic $r8$lambda$VrDRrkxzFaOSXM9uAqQEswlg2os(Lcom/sk/keeper/MainActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->startPairNotify()V

    return-void
.end method

.method public static synthetic $r8$lambda$arz21u_z3lWRJAZD5hhzcUES9i0(Lcom/sk/keeper/MainActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->showEnableWireless()V

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 52
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 71
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v0, p0, Lcom/sk/keeper/MainActivity;->ui:Landroid/os/Handler;

    .line 87
    const-string v0, ""

    filled-new-array {v0, v0, v0}, [Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/sk/keeper/MainActivity;->lastPids:[Ljava/lang/String;

    .line 88
    const/4 v1, 0x0

    filled-new-array {v1, v1, v1}, [I

    move-result-object v1

    iput-object v1, p0, Lcom/sk/keeper/MainActivity;->missPolls:[I

    .line 91
    iput-object v0, p0, Lcom/sk/keeper/MainActivity;->pairingEp:Ljava/lang/String;

    .line 92
    iput-object v0, p0, Lcom/sk/keeper/MainActivity;->connectEp:Ljava/lang/String;

    .line 94
    const-string v0, "-"

    iput-object v0, p0, Lcom/sk/keeper/MainActivity;->channelName:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$000(Lcom/sk/keeper/MainActivity;Ljava/lang/String;)V
    .locals 0

    .line 52
    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->updatePairNotification(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$100(Lcom/sk/keeper/MainActivity;)Ljava/lang/String;
    .locals 0

    .line 52
    iget-object p0, p0, Lcom/sk/keeper/MainActivity;->pairingEp:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic access$102(Lcom/sk/keeper/MainActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .line 52
    iput-object p1, p0, Lcom/sk/keeper/MainActivity;->pairingEp:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$200(Lcom/sk/keeper/MainActivity;Ljava/lang/String;)V
    .locals 0

    .line 52
    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->pairAndDeploy(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$300(Lcom/sk/keeper/MainActivity;)Landroid/os/Handler;
    .locals 0

    .line 52
    iget-object p0, p0, Lcom/sk/keeper/MainActivity;->ui:Landroid/os/Handler;

    return-object p0
.end method

.method static synthetic access$402(Lcom/sk/keeper/MainActivity;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .line 52
    iput-object p1, p0, Lcom/sk/keeper/MainActivity;->connectEp:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$500(Lcom/sk/keeper/MainActivity;)Landroid/widget/EditText;
    .locals 0

    .line 52
    iget-object p0, p0, Lcom/sk/keeper/MainActivity;->pairEndpointView:Landroid/widget/EditText;

    return-object p0
.end method

.method static synthetic access$600(Lcom/sk/keeper/MainActivity;Ljava/lang/String;)V
    .locals 0

    .line 52
    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->pushPairNotification(Ljava/lang/String;)V

    return-void
.end method

.method private batteryOk()Z
    .locals 3

    .line 1030
    const/4 v0, 0x0

    :try_start_0
    const-string v1, "power"

    invoke-virtual {p0, v1}, Lcom/sk/keeper/MainActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/os/PowerManager;

    .line 1031
    if-eqz v1, :cond_0

    invoke-virtual {p0}, Lcom/sk/keeper/MainActivity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/os/PowerManager;->isIgnoringBatteryOptimizations(Ljava/lang/String;)Z

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0

    .line 1032
    :catchall_0
    move-exception v1

    .line 1033
    return v0
.end method

.method private buildPairNotification(Ljava/lang/String;)Landroid/app/Notification;
    .locals 5

    .line 804
    new-instance v0, Landroid/app/RemoteInput$Builder;

    const-string v1, "sk_code"

    invoke-direct {v0, v1}, Landroid/app/RemoteInput$Builder;-><init>(Ljava/lang/String;)V

    .line 805
    const-string v1, "6 \u4f4d\u914d\u5bf9\u7801"

    invoke-virtual {v0, v1}, Landroid/app/RemoteInput$Builder;->setLabel(Ljava/lang/CharSequence;)Landroid/app/RemoteInput$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/RemoteInput$Builder;->build()Landroid/app/RemoteInput;

    move-result-object v0

    .line 806
    new-instance v1, Landroid/app/Notification$Action$Builder;

    .line 807
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->replyPendingIntent()Landroid/app/PendingIntent;

    move-result-object v2

    const v3, 0x108002d

    const-string v4, "\u8f93\u7801\u914d\u5bf9"

    invoke-direct {v1, v3, v4, v2}, Landroid/app/Notification$Action$Builder;-><init>(ILjava/lang/CharSequence;Landroid/app/PendingIntent;)V

    .line 808
    invoke-virtual {v1, v0}, Landroid/app/Notification$Action$Builder;->addRemoteInput(Landroid/app/RemoteInput;)Landroid/app/Notification$Action$Builder;

    move-result-object v0

    .line 809
    invoke-virtual {v0}, Landroid/app/Notification$Action$Builder;->build()Landroid/app/Notification$Action;

    move-result-object v0

    .line 810
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/sk/keeper/MainActivity;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 811
    const/high16 v2, 0xc000000

    const/4 v3, 0x1

    invoke-static {p0, v3, v1, v2}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v1

    .line 813
    new-instance v2, Landroid/app/Notification$Builder;

    const-string v4, "pair_v2"

    invoke-direct {v2, p0, v4}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    .line 814
    const v4, 0x108008a

    invoke-virtual {v2, v4}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    move-result-object v2

    .line 815
    const-string v4, "Keeper \u914d\u5bf9"

    invoke-virtual {v2, v4}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v2

    .line 816
    invoke-virtual {v2, p1}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v2

    new-instance v4, Landroid/app/Notification$BigTextStyle;

    invoke-direct {v4}, Landroid/app/Notification$BigTextStyle;-><init>()V

    .line 817
    invoke-virtual {v4, p1}, Landroid/app/Notification$BigTextStyle;->bigText(Ljava/lang/CharSequence;)Landroid/app/Notification$BigTextStyle;

    move-result-object p1

    invoke-virtual {v2, p1}, Landroid/app/Notification$Builder;->setStyle(Landroid/app/Notification$Style;)Landroid/app/Notification$Builder;

    move-result-object p1

    .line 818
    invoke-virtual {p1, v0}, Landroid/app/Notification$Builder;->addAction(Landroid/app/Notification$Action;)Landroid/app/Notification$Builder;

    move-result-object p1

    .line 819
    invoke-virtual {p1, v1}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    move-result-object p1

    .line 820
    invoke-virtual {p1, v3}, Landroid/app/Notification$Builder;->setOnlyAlertOnce(Z)Landroid/app/Notification$Builder;

    move-result-object p1

    .line 821
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/app/Notification$Builder;->setOngoing(Z)Landroid/app/Notification$Builder;

    move-result-object p1

    .line 822
    invoke-virtual {p1}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object p1

    .line 813
    return-object p1
.end method

.method private buildUi()V
    .locals 13

    .line 135
    invoke-virtual {p0}, Lcom/sk/keeper/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    const v1, -0xf7f3ef

    invoke-virtual {v0, v1}, Landroid/view/Window;->setStatusBarColor(I)V

    .line 136
    invoke-virtual {p0}, Lcom/sk/keeper/MainActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/Window;->setNavigationBarColor(I)V

    .line 138
    new-instance v0, Landroid/widget/ScrollView;

    invoke-direct {v0, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 139
    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->setBackgroundColor(I)V

    .line 140
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->setFillViewport(Z)V

    .line 142
    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 143
    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 144
    const/16 v3, 0x18

    invoke-direct {p0, v3}, Lcom/sk/keeper/MainActivity;->dp(I)I

    move-result v3

    .line 145
    const/16 v4, 0x30

    invoke-direct {p0, v4}, Lcom/sk/keeper/MainActivity;->dp(I)I

    move-result v5

    const/16 v6, 0x20

    invoke-direct {p0, v6}, Lcom/sk/keeper/MainActivity;->dp(I)I

    move-result v6

    invoke-virtual {v2, v3, v5, v3, v6}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 146
    new-instance v3, Landroid/view/ViewGroup$LayoutParams;

    const/4 v5, -0x1

    const/4 v6, -0x2

    invoke-direct {v3, v5, v6}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v2, v3}, Landroid/widget/ScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 149
    new-instance v3, Landroid/widget/TextView;

    invoke-direct {v3, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 150
    const-string v7, "KEEPER"

    invoke-virtual {v3, v7}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 151
    const v7, -0x170e08

    invoke-virtual {v3, v7}, Landroid/widget/TextView;->setTextColor(I)V

    .line 152
    const/high16 v7, 0x41f00000    # 30.0f

    invoke-virtual {v3, v7}, Landroid/widget/TextView;->setTextSize(F)V

    .line 153
    const-string v7, "sans-serif-medium"

    const/4 v8, 0x0

    invoke-static {v7, v8}, Landroid/graphics/Typeface;->create(Ljava/lang/String;I)Landroid/graphics/Typeface;

    move-result-object v9

    invoke-virtual {v3, v9}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 154
    const v9, 0x3e6147ae    # 0.22f

    invoke-virtual {v3, v9}, Landroid/widget/TextView;->setLetterSpacing(F)V

    .line 155
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 157
    new-instance v3, Landroid/widget/TextView;

    invoke-direct {v3, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 158
    const-string v9, "shell \u5b88\u62a4\u6e05\u7406 \u00b7 \u533f\u540d\u5185\u5b58\u8f7d\u8377"

    invoke-virtual {v3, v9}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 159
    const v9, -0x907f6f

    invoke-virtual {v3, v9}, Landroid/widget/TextView;->setTextColor(I)V

    .line 160
    const/high16 v10, 0x41400000    # 12.0f

    invoke-virtual {v3, v10}, Landroid/widget/TextView;->setTextSize(F)V

    .line 161
    const/4 v11, 0x2

    invoke-direct {p0, v11}, Lcom/sk/keeper/MainActivity;->dp(I)I

    move-result v11

    invoke-virtual {v3, v8, v11, v8, v8}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 162
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 164
    new-instance v3, Landroid/widget/TextView;

    invoke-direct {v3, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Lcom/sk/keeper/MainActivity;->badge:Landroid/widget/TextView;

    .line 165
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->badge:Landroid/widget/TextView;

    const-string v11, "\u672a\u542f\u52a8"

    invoke-virtual {v3, v11}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 166
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->badge:Landroid/widget/TextView;

    invoke-virtual {v3, v10}, Landroid/widget/TextView;->setTextSize(F)V

    .line 167
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->badge:Landroid/widget/TextView;

    invoke-virtual {v3, v9}, Landroid/widget/TextView;->setTextColor(I)V

    .line 168
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v6, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 170
    const/16 v9, 0x1c

    invoke-direct {p0, v9}, Lcom/sk/keeper/MainActivity;->dp(I)I

    move-result v11

    iput v11, v3, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 171
    iget-object v11, p0, Lcom/sk/keeper/MainActivity;->badge:Landroid/widget/TextView;

    invoke-virtual {v2, v11, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 173
    new-instance v3, Landroid/widget/TextView;

    invoke-direct {v3, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Lcom/sk/keeper/MainActivity;->hint:Landroid/widget/TextView;

    .line 174
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->hint:Landroid/widget/TextView;

    const-string v11, "\u70b9\u4e0b\u9762\u7684\u6309\u94ae\u5f00\u59cb\u3002"

    invoke-virtual {v3, v11}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 175
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->hint:Landroid/widget/TextView;

    const v11, -0x604d3d

    invoke-virtual {v3, v11}, Landroid/widget/TextView;->setTextColor(I)V

    .line 176
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->hint:Landroid/widget/TextView;

    const/high16 v11, 0x41500000    # 13.0f

    invoke-virtual {v3, v11}, Landroid/widget/TextView;->setTextSize(F)V

    .line 177
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 179
    const/16 v11, 0xa

    invoke-direct {p0, v11}, Lcom/sk/keeper/MainActivity;->dp(I)I

    move-result v11

    iput v11, v3, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 180
    iget-object v11, p0, Lcom/sk/keeper/MainActivity;->hint:Landroid/widget/TextView;

    invoke-virtual {v2, v11, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 182
    new-instance v3, Landroid/widget/Button;

    invoke-direct {v3, p0}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    .line 183
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    const-string v11, "\u5f00\u59cb\u6d4b\u8bd5"

    invoke-virtual {v3, v11}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 184
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    const/high16 v11, 0x41880000    # 17.0f

    invoke-virtual {v3, v11}, Landroid/widget/Button;->setTextSize(F)V

    .line 185
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    const v11, -0xfbedf4

    invoke-virtual {v3, v11}, Landroid/widget/Button;->setTextColor(I)V

    .line 186
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    invoke-static {v7, v8}, Landroid/graphics/Typeface;->create(Ljava/lang/String;I)Landroid/graphics/Typeface;

    move-result-object v7

    invoke-virtual {v3, v7}, Landroid/widget/Button;->setTypeface(Landroid/graphics/Typeface;)V

    .line 187
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    invoke-virtual {v3, v8}, Landroid/widget/Button;->setAllCaps(Z)V

    .line 188
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    const v7, -0xe93866

    invoke-direct {p0, v7, v8, v8}, Lcom/sk/keeper/MainActivity;->roundRect(III)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v7

    invoke-virtual {v3, v7}, Landroid/widget/Button;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 189
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    .line 190
    const/16 v7, 0x3a

    invoke-direct {p0, v7}, Lcom/sk/keeper/MainActivity;->dp(I)I

    move-result v7

    invoke-direct {v3, v5, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 191
    const/16 v7, 0x12

    invoke-direct {p0, v7}, Lcom/sk/keeper/MainActivity;->dp(I)I

    move-result v11

    iput v11, v3, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 192
    iget-object v11, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    invoke-virtual {v2, v11, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 193
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    new-instance v11, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda23;

    invoke-direct {v11, p0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda23;-><init>(Lcom/sk/keeper/MainActivity;)V

    invoke-virtual {v3, v11}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 199
    new-instance v3, Landroid/widget/TextView;

    invoke-direct {v3, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Lcom/sk/keeper/MainActivity;->status:Landroid/widget/TextView;

    .line 200
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->status:Landroid/widget/TextView;

    const-string v11, "\u7b49\u5f85\u542f\u52a8\n"

    invoke-virtual {v3, v11}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 201
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->status:Landroid/widget/TextView;

    const v11, -0x705c4a

    invoke-virtual {v3, v11}, Landroid/widget/TextView;->setTextColor(I)V

    .line 202
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->status:Landroid/widget/TextView;

    invoke-virtual {v3, v10}, Landroid/widget/TextView;->setTextSize(F)V

    .line 203
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->status:Landroid/widget/TextView;

    sget-object v10, Landroid/graphics/Typeface;->MONOSPACE:Landroid/graphics/Typeface;

    invoke-virtual {v3, v10}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 204
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->status:Landroid/widget/TextView;

    const/4 v10, 0x4

    invoke-direct {p0, v10}, Lcom/sk/keeper/MainActivity;->dp(I)I

    move-result v10

    int-to-float v10, v10

    const/high16 v11, 0x3f800000    # 1.0f

    invoke-virtual {v3, v10, v11}, Landroid/widget/TextView;->setLineSpacing(FF)V

    .line 205
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 207
    const/16 v10, 0x16

    invoke-direct {p0, v10}, Lcom/sk/keeper/MainActivity;->dp(I)I

    move-result v10

    iput v10, v3, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 208
    iget-object v10, p0, Lcom/sk/keeper/MainActivity;->status:Landroid/widget/TextView;

    invoke-virtual {v2, v10, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 210
    new-instance v3, Landroid/widget/Button;

    invoke-direct {v3, p0}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Lcom/sk/keeper/MainActivity;->isolate:Landroid/widget/Button;

    .line 211
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->isolate:Landroid/widget/Button;

    const-string v10, "\u9694\u79bb\u65e0\u7ebf\u8c03\u8bd5"

    invoke-virtual {v3, v10}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 212
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->isolate:Landroid/widget/Button;

    const/high16 v10, 0x41600000    # 14.0f

    invoke-virtual {v3, v10}, Landroid/widget/Button;->setTextSize(F)V

    .line 213
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->isolate:Landroid/widget/Button;

    const v12, -0x1f56c5

    invoke-virtual {v3, v12}, Landroid/widget/Button;->setTextColor(I)V

    .line 214
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->isolate:Landroid/widget/Button;

    invoke-virtual {v3, v8}, Landroid/widget/Button;->setAllCaps(Z)V

    .line 215
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->isolate:Landroid/widget/Button;

    invoke-direct {p0, v8, v12, v1}, Lcom/sk/keeper/MainActivity;->roundRect(III)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v12

    invoke-virtual {v3, v12}, Landroid/widget/Button;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 216
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    .line 217
    invoke-direct {p0, v4}, Lcom/sk/keeper/MainActivity;->dp(I)I

    move-result v12

    invoke-direct {v3, v5, v12}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 218
    const/16 v12, 0xc

    invoke-direct {p0, v12}, Lcom/sk/keeper/MainActivity;->dp(I)I

    move-result v12

    iput v12, v3, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 219
    iget-object v12, p0, Lcom/sk/keeper/MainActivity;->isolate:Landroid/widget/Button;

    invoke-virtual {v2, v12, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 220
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->isolate:Landroid/widget/Button;

    new-instance v12, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda24;

    invoke-direct {v12, p0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda24;-><init>(Lcom/sk/keeper/MainActivity;)V

    invoke-virtual {v3, v12}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 222
    new-instance v3, Landroid/widget/Button;

    invoke-direct {v3, p0}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V

    iput-object v3, p0, Lcom/sk/keeper/MainActivity;->exit:Landroid/widget/Button;

    .line 223
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->exit:Landroid/widget/Button;

    const-string v12, "\u7d27\u6025\u9000\u51fa"

    invoke-virtual {v3, v12}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 224
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->exit:Landroid/widget/Button;

    invoke-virtual {v3, v10}, Landroid/widget/Button;->setTextSize(F)V

    .line 225
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->exit:Landroid/widget/Button;

    const v10, -0x1ab7b3

    invoke-virtual {v3, v10}, Landroid/widget/Button;->setTextColor(I)V

    .line 226
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->exit:Landroid/widget/Button;

    invoke-virtual {v3, v8}, Landroid/widget/Button;->setAllCaps(Z)V

    .line 227
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->exit:Landroid/widget/Button;

    invoke-direct {p0, v8, v10, v1}, Lcom/sk/keeper/MainActivity;->roundRect(III)Landroid/graphics/drawable/GradientDrawable;

    move-result-object v1

    invoke-virtual {v3, v1}, Landroid/widget/Button;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 228
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    .line 229
    invoke-direct {p0, v4}, Lcom/sk/keeper/MainActivity;->dp(I)I

    move-result v3

    invoke-direct {v1, v5, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 230
    invoke-direct {p0, v9}, Lcom/sk/keeper/MainActivity;->dp(I)I

    move-result v3

    iput v3, v1, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 231
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->exit:Landroid/widget/Button;

    invoke-virtual {v2, v3, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 232
    iget-object v1, p0, Lcom/sk/keeper/MainActivity;->exit:Landroid/widget/Button;

    new-instance v3, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda25;

    invoke-direct {v3, p0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda25;-><init>(Lcom/sk/keeper/MainActivity;)V

    invoke-virtual {v1, v3}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 234
    new-instance v1, Landroid/widget/TextView;

    invoke-direct {v1, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 235
    const-string v3, "\u8f7d\u8377\u8dd1\u5728 shell(uid 2000) \u7684\u72ec\u7acb\u4f1a\u8bdd\u91cc, ELF \u53ea\u5b58\u5728\u4e8e memfd \u533f\u540d\u5185\u5b58\u3002\n\u7d27\u6025\u9000\u51fa\u540e\u4e0d\u4f1a\u518d\u628a\u672c\u5e94\u7528\u62c9\u8d77\u3002"

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 237
    const v3, -0xbbada1

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setTextColor(I)V

    .line 238
    const/high16 v3, 0x41200000    # 10.0f

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setTextSize(F)V

    .line 239
    const/4 v3, 0x3

    invoke-direct {p0, v3}, Lcom/sk/keeper/MainActivity;->dp(I)I

    move-result v3

    int-to-float v3, v3

    invoke-virtual {v1, v3, v11}, Landroid/widget/TextView;->setLineSpacing(FF)V

    .line 240
    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v3, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 242
    invoke-direct {p0, v7}, Lcom/sk/keeper/MainActivity;->dp(I)I

    move-result v4

    iput v4, v3, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 243
    invoke-virtual {v2, v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 245
    invoke-virtual {p0, v0}, Lcom/sk/keeper/MainActivity;->setContentView(Landroid/view/View;)V

    .line 246
    return-void
.end method

.method private canWriteSecure()Z
    .locals 2

    .line 1241
    const/4 v0, 0x0

    :try_start_0
    const-string v1, "android.permission.WRITE_SECURE_SETTINGS"

    invoke-virtual {p0, v1}, Lcom/sk/keeper/MainActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v1, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0

    .line 1243
    :catchall_0
    move-exception v1

    .line 1244
    return v0
.end method

.method private candidates(Lcom/sk/keeper/AdbCli;Ljava/lang/String;)Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/sk/keeper/AdbCli;",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 1012
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 1013
    iget-object v1, p0, Lcom/sk/keeper/MainActivity;->connectEp:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    .line 1014
    iget-object v1, p0, Lcom/sk/keeper/MainActivity;->connectEp:Ljava/lang/String;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1016
    :cond_0
    const-string v1, "_adb-tls-connect._tcp"

    invoke-virtual {p1, v1}, Lcom/sk/keeper/AdbCli;->mdnsFind(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 1017
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_1

    .line 1018
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1021
    :cond_1
    invoke-interface {v0, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1022
    return-object v0
.end method

.method private confirmExit()V
    .locals 3

    .line 1124
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 1125
    const-string v1, "\u7d27\u6025\u9000\u51fa"

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 1126
    const-string v1, "\u5199\u5165\u505c\u6b62\u6807\u8bb0 \u2192 \u4e24\u4e2a\u8f7d\u8377\u81ea\u884c\u9000\u51fa \u2192 \u518d\u515c\u5e95\u5f3a\u6740\u3002\n\u4e4b\u540e\u4e0d\u4f1a\u518d\u81ea\u52a8\u62c9\u8d77\u672c\u5e94\u7528\u3002"

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda7;

    invoke-direct {v1, p0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda7;-><init>(Lcom/sk/keeper/MainActivity;)V

    .line 1128
    const-string v2, "\u9000\u51fa"

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 1129
    const-string v1, "\u53d6\u6d88"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 1130
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 1131
    return-void
.end method

.method private confirmIsolate()V
    .locals 3

    .line 1075
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->shell:Lcom/sk/keeper/Shell;

    if-nez v0, :cond_0

    .line 1076
    const-string v0, "\u5148\u70b9\u5f00\u59cb\u6d4b\u8bd5, \u90e8\u7f72\u6210\u529f\u540e\u624d\u80fd\u9694\u79bb"

    invoke-direct {p0, v0}, Lcom/sk/keeper/MainActivity;->toast(Ljava/lang/String;)V

    .line 1077
    return-void

    .line 1079
    :cond_0
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 1080
    const-string v1, "\u9694\u79bb\u65e0\u7ebf\u8c03\u8bd5"

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 1081
    const-string v1, "\u628a\u7cfb\u7edf\u7684\u300e\u65e0\u7ebf\u8c03\u8bd5\u300f\u5f00\u5173\u5173\u6389\u3002\n\n\u00b7 \u4e09\u4e2a\u8f7d\u8377\u8dd1\u5728 shell \u4fa7, \u4e0d\u53d7\u5f71\u54cd, \u7ee7\u7eed\u5de5\u4f5c\n\u00b7 \u522b\u4eba(\u5176\u4ed6 ADB \u5de5\u5177)\u4e5f\u5c31\u6ca1\u6709\u901a\u9053\u6765\u505c\u6211\u4eec\n\u00b7 \u4ee3\u4ef7: \u672c\u5e94\u7528\u7acb\u523b\u5931\u53bb\u901a\u9053, \u754c\u9762\u8f6c\u4e3a\u300e\u5df2\u9694\u79bb\u300f;\n  \u8981\u6062\u590d\u5f97\u53bb\u7cfb\u7edf\u8bbe\u7f6e\u91cc\u91cd\u65b0\u6253\u5f00\u65e0\u7ebf\u8c03\u8bd5\n\n\u9002\u5408\u786e\u8ba4\u90e8\u7f72\u5b8c\u6210\u3001\u4e0d\u518d\u9700\u8981\u73b0\u573a\u8c03\u8bd5\u7684\u65f6\u5019\u3002"

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda21;

    invoke-direct {v1, p0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda21;-><init>(Lcom/sk/keeper/MainActivity;)V

    .line 1087
    const-string v2, "\u9694\u79bb"

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 1088
    const-string v1, "\u53d6\u6d88"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 1089
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 1090
    return-void
.end method

.method private debugBridge()Lcom/sk/keeper/Shell;
    .locals 4

    .line 360
    const/4 v0, 0x0

    :try_start_0
    const-string v1, "com.sk.keeper.DebugBridge"

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .line 361
    const-string v2, "tryOpen"

    const-class v3, Landroid/content/Context;

    filled-new-array {v3}, [Ljava/lang/Class;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v1, v0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 362
    instance-of v2, v1, Lcom/sk/keeper/Shell;

    if-eqz v2, :cond_0

    check-cast v1, Lcom/sk/keeper/Shell;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-object v0, v1

    :cond_0
    return-object v0

    .line 363
    :catchall_0
    move-exception v1

    .line 364
    return-object v0
.end method

.method private degraded(Ljava/lang/String;)V
    .locals 2

    .line 373
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/sk/keeper/MainActivity;->busy:Z

    .line 374
    iput-boolean v0, p0, Lcom/sk/keeper/MainActivity;->running:Z

    .line 375
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->ui:Landroid/os/Handler;

    new-instance v1, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda32;

    invoke-direct {v1, p0, p1}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda32;-><init>(Lcom/sk/keeper/MainActivity;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 385
    return-void
.end method

.method private deployAndRun()V
    .locals 6

    .line 418
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->shell:Lcom/sk/keeper/Shell;

    invoke-static {v0}, Lcom/sk/keeper/Payloads;->clearStopFile(Lcom/sk/keeper/Shell;)V

    .line 428
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    const-string v1, "armed"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->shell:Lcom/sk/keeper/Shell;

    invoke-static {v0}, Lcom/sk/keeper/Payloads;->alive(Lcom/sk/keeper/Shell;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    const-string v0, ""

    .line 430
    :goto_0
    const-string v3, "sweep="

    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_1

    const-string v3, "revive="

    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_1

    const-string v3, "guard="

    invoke-virtual {v0, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 431
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "OK \u590d\u7528 "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const/16 v4, 0xa

    const/16 v5, 0x20

    invoke-virtual {v0, v4, v5}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 433
    :cond_1
    const-string v0, "\u90e8\u7f72\u8f7d\u8377\u2026"

    invoke-direct {p0, v0}, Lcom/sk/keeper/MainActivity;->post(Ljava/lang/String;)V

    .line 434
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->shell:Lcom/sk/keeper/Shell;

    invoke-static {p0, v0}, Lcom/sk/keeper/Payloads;->deploy(Landroid/content/Context;Lcom/sk/keeper/Shell;)Ljava/lang/String;

    move-result-object v0

    .line 436
    :goto_1
    const-string v3, "OK"

    invoke-virtual {v0, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_2

    .line 437
    invoke-direct {p0, v0}, Lcom/sk/keeper/MainActivity;->fail(Ljava/lang/String;)V

    .line 438
    return-void

    .line 440
    :cond_2
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->shell:Lcom/sk/keeper/Shell;

    invoke-interface {v3}, Lcom/sk/keeper/Shell;->endpoint()Ljava/lang/String;

    move-result-object v3

    .line 441
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v4

    invoke-interface {v4}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v4

    const/4 v5, 0x1

    invoke-interface {v4, v1, v5}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    .line 442
    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_3

    .line 443
    const-string v4, "endpoint"

    invoke-interface {v1, v4, v3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 445
    :cond_3
    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 447
    iput-boolean v5, p0, Lcom/sk/keeper/MainActivity;->running:Z

    .line 448
    iput-boolean v2, p0, Lcom/sk/keeper/MainActivity;->busy:Z

    .line 449
    iget-object v1, p0, Lcom/sk/keeper/MainActivity;->ui:Landroid/os/Handler;

    new-instance v3, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda4;

    invoke-direct {v3, p0, v0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda4;-><init>(Lcom/sk/keeper/MainActivity;Ljava/lang/String;)V

    invoke-virtual {v1, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 455
    iput-boolean v2, p0, Lcom/sk/keeper/MainActivity;->isolated:Z

    .line 456
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->missPolls:[I

    iget-object v1, p0, Lcom/sk/keeper/MainActivity;->missPolls:[I

    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->missPolls:[I

    const/4 v4, 0x2

    aput v2, v3, v4

    aput v2, v1, v5

    aput v2, v0, v2

    .line 457
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "isolated"

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 458
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->startChannelService()V

    .line 459
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->startPolling()V

    .line 460
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda5;

    invoke-direct {v1, p0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda5;-><init>(Lcom/sk/keeper/MainActivity;)V

    const-string v2, "sk-first"

    invoke-direct {v0, v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 468
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 469
    return-void
.end method

.method private doEmergency()V
    .locals 3

    .line 1134
    const-string v0, "\u9000\u51fa\u4e2d"

    const v1, -0x1ab7b3

    invoke-direct {p0, v0, v1}, Lcom/sk/keeper/MainActivity;->setBadge(Ljava/lang/String;I)V

    .line 1135
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->hint:Landroid/widget/TextView;

    const-string v1, "\u6b63\u5728\u505c\u6b62\u8f7d\u8377\u2026"

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 1136
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->stopChannelService()V

    .line 1137
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda22;

    invoke-direct {v1, p0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda22;-><init>(Lcom/sk/keeper/MainActivity;)V

    const-string v2, "sk-exit"

    invoke-direct {v0, v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 1168
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 1169
    return-void
.end method

.method private doIsolate()V
    .locals 3

    .line 1093
    const-string v0, "\u9694\u79bb\u4e2d"

    const v1, -0x1c4cbf

    invoke-direct {p0, v0, v1}, Lcom/sk/keeper/MainActivity;->setBadge(Ljava/lang/String;I)V

    .line 1094
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->hint:Landroid/widget/TextView;

    const-string v1, "\u6b63\u5728\u5173\u95ed\u65e0\u7ebf\u8c03\u8bd5\u2026"

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 1095
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda18;

    invoke-direct {v1, p0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda18;-><init>(Lcom/sk/keeper/MainActivity;)V

    const-string v2, "sk-isolate"

    invoke-direct {v0, v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 1118
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 1119
    return-void
.end method

.method private dp(I)I
    .locals 2

    .line 1249
    int-to-float p1, p1

    .line 1250
    invoke-virtual {p0}, Lcom/sk/keeper/MainActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    .line 1249
    const/4 v1, 0x1

    invoke-static {v1, p1, v0}, Landroid/util/TypedValue;->applyDimension(IFLandroid/util/DisplayMetrics;)F

    move-result p1

    float-to-int p1, p1

    return p1
.end method

.method private ensureBatteryWhitelist()V
    .locals 4

    .line 1047
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->batteryOk()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1048
    return-void

    .line 1056
    :cond_0
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    const/4 v1, 0x0

    const-string v2, "battery_asked"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 1057
    return-void

    .line 1059
    :cond_1
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const/4 v1, 0x1

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 1061
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.settings.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "package:"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 1062
    invoke-virtual {p0}, Lcom/sk/keeper/MainActivity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    .line 1061
    invoke-virtual {p0, v0}, Lcom/sk/keeper/MainActivity;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1069
    goto :goto_0

    .line 1063
    :catchall_0
    move-exception v0

    .line 1066
    :try_start_1
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.settings.IGNORE_BATTERY_OPTIMIZATION_SETTINGS"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Lcom/sk/keeper/MainActivity;->startActivity(Landroid/content/Intent;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1068
    goto :goto_0

    .line 1067
    :catchall_1
    move-exception v0

    .line 1070
    :goto_0
    return-void
.end method

.method private fail(Ljava/lang/String;)V
    .locals 3

    .line 1202
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/sk/keeper/MainActivity;->busy:Z

    .line 1203
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[fail] "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "Skeeper"

    invoke-static {v2, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1204
    iget-object v1, p0, Lcom/sk/keeper/MainActivity;->pairReceiver:Landroid/content/BroadcastReceiver;

    if-eqz v1, :cond_0

    .line 1205
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u5931\u8d25: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\n"

    invoke-virtual {p1, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    aget-object v0, v2, v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/sk/keeper/MainActivity;->updatePairNotification(Ljava/lang/String;)V

    .line 1207
    :cond_0
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->ui:Landroid/os/Handler;

    new-instance v1, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda26;

    invoke-direct {v1, p0, p1}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda26;-><init>(Lcom/sk/keeper/MainActivity;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 1213
    return-void
.end method

.method private static field(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 5

    .line 631
    const-string v0, ""

    if-nez p0, :cond_0

    .line 632
    return-object v0

    .line 634
    :cond_0
    const-string v1, "\n"

    invoke-virtual {p0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p0

    array-length v1, p0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_2

    aget-object v3, p0, v2

    .line 635
    invoke-virtual {v3, p1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 636
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p0

    invoke-virtual {v3, p0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    .line 637
    const/16 p1, 0xd

    const/16 v0, 0x20

    invoke-virtual {p0, p1, v0}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object p0

    return-object p0

    .line 634
    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 640
    :cond_2
    return-object v0
.end method

.method static synthetic lambda$doEmergency$28()V
    .locals 1

    .line 1166
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v0

    invoke-static {v0}, Landroid/os/Process;->killProcess(I)V

    return-void
.end method

.method private static oneLine(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .line 611
    if-nez p0, :cond_0

    .line 612
    const-string p0, ""

    return-object p0

    .line 614
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    const/16 v0, 0xa

    const/16 v1, 0x20

    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object p0

    .line 615
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v1, 0xa0

    if-le v0, v1, :cond_1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v2, 0x0

    invoke-virtual {p0, v2, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, "\u2026"

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    :cond_1
    return-object p0
.end method

.method private pairAndDeploy(Ljava/lang/String;)V
    .locals 6

    .line 935
    const-string v0, "Skeeper"

    :try_start_0
    const-string v1, "\u914d\u5bf9\u4e2d\u2026"

    invoke-direct {p0, v1}, Lcom/sk/keeper/MainActivity;->post(Ljava/lang/String;)V

    .line 936
    new-instance v1, Lcom/sk/keeper/AdbCli;

    invoke-direct {v1, p0}, Lcom/sk/keeper/AdbCli;-><init>(Landroid/content/Context;)V

    .line 937
    invoke-virtual {v1}, Lcom/sk/keeper/AdbCli;->install()Ljava/io/File;

    .line 938
    invoke-virtual {v1}, Lcom/sk/keeper/AdbCli;->canRun()Z

    move-result v2

    if-nez v2, :cond_0

    .line 939
    const-string p1, "\u5185\u7f6e adb \u65e0\u6cd5\u6267\u884c"

    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->fail(Ljava/lang/String;)V

    .line 940
    return-void

    .line 942
    :cond_0
    invoke-virtual {v1}, Lcom/sk/keeper/AdbCli;->killServer()V

    .line 943
    const-wide/16 v2, 0x190

    invoke-static {v2, v3}, Lcom/sk/keeper/MainActivity;->sleep(J)V

    .line 944
    invoke-virtual {v1}, Lcom/sk/keeper/AdbCli;->keygen()Ljava/lang/String;

    .line 951
    const-string v2, "\u542f\u52a8 adb \u670d\u52a1\u2026"

    invoke-direct {p0, v2}, Lcom/sk/keeper/MainActivity;->post(Ljava/lang/String;)V

    .line 952
    invoke-virtual {v1}, Lcom/sk/keeper/AdbCli;->startServer()Z

    move-result v2

    if-nez v2, :cond_1

    .line 953
    const-string p1, "adb server \u8d77\u4e0d\u6765(\u8fde\u7eed 3 \u8f6e)\u3002\n\u5e38\u89c1\u539f\u56e0: \u5176\u5b83 ADB \u5de5\u5177\u5360\u7528\u7aef\u53e3 / \u7cfb\u7edf\u9650\u5236\u540e\u53f0\u6267\u884c\u3002\n\u91cd\u542f\u624b\u673a\u540e\u518d\u8bd5\u4e00\u6b21\u3002"

    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->fail(Ljava/lang/String;)V

    .line 956
    return-void

    .line 959
    :cond_1
    iget-object v2, p0, Lcom/sk/keeper/MainActivity;->pairingEp:Ljava/lang/String;

    .line 960
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_2

    .line 961
    const-string v2, "_adb-tls-pairing._tcp"

    invoke-virtual {v1, v2}, Lcom/sk/keeper/AdbCli;->mdnsFind(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 963
    :cond_2
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_3

    .line 964
    const-string p1, "\u8fd8\u6ca1\u53d1\u73b0\u914d\u5bf9\u7aef\u70b9\n\u8bf7\u4fdd\u6301\u300e\u4f7f\u7528\u914d\u5bf9\u7801\u914d\u5bf9\u8bbe\u5907\u300f\u5f39\u7a97\u6253\u5f00, \u518d\u8bd5\u4e00\u6b21"

    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->fail(Ljava/lang/String;)V

    .line 965
    return-void

    .line 968
    :cond_3
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v4

    invoke-interface {v4}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v4

    const-string v5, "endpoint"

    invoke-interface {v4, v5, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v4}, Landroid/content/SharedPreferences$Editor;->apply()V

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "\u914d\u5bf9 "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/sk/keeper/MainActivity;->post(Ljava/lang/String;)V

    .line 969
    invoke-virtual {v1, v2, p1}, Lcom/sk/keeper/AdbCli;->pair(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 970
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[pair] "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v0, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 971
    const-string v3, "Successfully paired"

    invoke-virtual {p1, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_4

    const-string v3, "Already paired"

    invoke-virtual {p1, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_4

    const-string v3, "\u6210\u529f"

    .line 972
    invoke-virtual {p1, v3}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_4

    .line 973
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\u914d\u5bf9\u5931\u8d25\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "\n\n\u63d0\u9192: \u914d\u5bf9\u7801 30~60 \u79d2\u5c31\u8fc7\u671f\u3002\u91cd\u8bd5\u524d\u8bf7\u5148\u5173\u6389\u7cfb\u7edf\u300e\u4f7f\u7528\u914d\u5bf9\u7801\u914d\u5bf9\u8bbe\u5907\u300f\u5f39\u7a97\u518d\u91cd\u65b0\u6253\u5f00, \u62ff\u65b0\u7801\u518d\u8bd5\u3002"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->fail(Ljava/lang/String;)V

    .line 976
    return-void

    .line 979
    :cond_4
    const-wide/16 v3, 0x258

    invoke-static {v3, v4}, Lcom/sk/keeper/MainActivity;->sleep(J)V

    .line 980
    nop

    .line 981
    invoke-direct {p0, v1, v2}, Lcom/sk/keeper/MainActivity;->candidates(Lcom/sk/keeper/AdbCli;Ljava/lang/String;)Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_5
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_9

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 982
    if-eqz v2, :cond_5

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_6

    .line 983
    goto :goto_0

    .line 985
    :cond_6
    invoke-virtual {v1, v2}, Lcom/sk/keeper/AdbCli;->connect(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 986
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "[pair] connect "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " => "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v0, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 987
    const-string v4, "connected to"

    invoke-virtual {v3, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_8

    const-string v4, "already connected"

    invoke-virtual {v3, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_7

    goto :goto_1

    .line 991
    :cond_7
    goto :goto_0

    .line 988
    :cond_8
    :goto_1
    nop

    .line 989
    goto :goto_2

    .line 981
    :cond_9
    const/4 v2, 0x0

    .line 992
    :goto_2
    if-nez v2, :cond_a

    .line 993
    const-string p1, "\u914d\u5bf9\u6210\u529f, \u4f46\u8fde\u63a5\u7aef\u53e3\u8fde\u4e0d\u4e0a\n\u8bf7\u786e\u8ba4\u65e0\u7ebf\u8c03\u8bd5\u4ecd\u7136\u5f00\u7740"

    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->fail(Ljava/lang/String;)V

    .line 994
    return-void

    .line 997
    :cond_a
    new-instance p1, Lcom/sk/keeper/AdbShell;

    invoke-direct {p1, v1, v2}, Lcom/sk/keeper/AdbShell;-><init>(Lcom/sk/keeper/AdbCli;Ljava/lang/String;)V

    .line 998
    const-string v0, "id"

    invoke-virtual {p1, v0}, Lcom/sk/keeper/AdbShell;->exec(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 999
    const-string v1, "uid=2000"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_b

    .line 1000
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\u5df2\u8fde\u63a5, \u4f46\u62ff\u4e0d\u5230 shell \u8eab\u4efd\n"

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->fail(Ljava/lang/String;)V

    .line 1001
    return-void

    .line 1003
    :cond_b
    iput-object p1, p0, Lcom/sk/keeper/MainActivity;->shell:Lcom/sk/keeper/Shell;

    .line 1004
    invoke-virtual {p1}, Lcom/sk/keeper/AdbShell;->label()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/sk/keeper/MainActivity;->channelName:Ljava/lang/String;

    .line 1005
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->deployAndRun()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1008
    goto :goto_3

    .line 1006
    :catchall_0
    move-exception p1

    .line 1007
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\u914d\u5bf9\u5f02\u5e38: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->fail(Ljava/lang/String;)V

    .line 1009
    :goto_3
    return-void
.end method

.method private post(Ljava/lang/String;)V
    .locals 2

    .line 1216
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->ui:Landroid/os/Handler;

    new-instance v1, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda6;

    invoke-direct {v1, p0, p1}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda6;-><init>(Lcom/sk/keeper/MainActivity;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 1217
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->pairReceiver:Landroid/content/BroadcastReceiver;

    if-eqz v0, :cond_0

    .line 1218
    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->updatePairNotification(Ljava/lang/String;)V

    .line 1220
    :cond_0
    return-void
.end method

.method private prefs()Landroid/content/SharedPreferences;
    .locals 2

    .line 260
    const-string v0, "keeper"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/sk/keeper/MainActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    return-object v0
.end method

.method private static pretty(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    .line 619
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    .line 620
    const/4 v0, 0x0

    move v1, v0

    .line 621
    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v1, v2, :cond_0

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/Character;->isDigit(C)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 622
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 624
    :cond_0
    if-lez v1, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v1, v2, :cond_1

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    const/16 v3, 0x20

    if-ne v2, v3, :cond_1

    .line 625
    add-int/lit8 v1, v1, 0x1

    invoke-virtual {p0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p0

    .line 627
    :cond_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    const/16 v2, 0x60

    if-le v1, v2, :cond_2

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0, v0, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v0, "\u2026"

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    :cond_2
    return-object p0
.end method

.method private pushPairNotification(Ljava/lang/String;)V
    .locals 2

    .line 826
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->pairReceiver:Landroid/content/BroadcastReceiver;

    if-nez v0, :cond_0

    .line 827
    return-void

    .line 830
    :cond_0
    :try_start_0
    const-class v0, Landroid/app/NotificationManager;

    invoke-virtual {p0, v0}, Lcom/sk/keeper/MainActivity;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    .line 831
    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->buildPairNotification(Ljava/lang/String;)Landroid/app/Notification;

    move-result-object p1

    const/16 v1, 0x1092

    invoke-virtual {v0, v1, p1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 834
    goto :goto_0

    .line 832
    :catchall_0
    move-exception p1

    .line 833
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[pair-noti] \u53d1\u9001\u5931\u8d25: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "Skeeper"

    invoke-static {v0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 835
    :goto_0
    return-void
.end method

.method private registerPairReceiver()V
    .locals 3

    .line 735
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->pairReceiver:Landroid/content/BroadcastReceiver;

    if-eqz v0, :cond_0

    .line 736
    return-void

    .line 738
    :cond_0
    new-instance v0, Lcom/sk/keeper/MainActivity$1;

    invoke-direct {v0, p0}, Lcom/sk/keeper/MainActivity$1;-><init>(Lcom/sk/keeper/MainActivity;)V

    iput-object v0, p0, Lcom/sk/keeper/MainActivity;->pairReceiver:Landroid/content/BroadcastReceiver;

    .line 759
    new-instance v0, Landroid/content/IntentFilter;

    const-string v1, "com.sk.keeper.PAIR_REPLY"

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    .line 760
    const-string v1, "android.intent.category.DEFAULT"

    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addCategory(Ljava/lang/String;)V

    .line 761
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x21

    if-lt v1, v2, :cond_1

    .line 762
    iget-object v1, p0, Lcom/sk/keeper/MainActivity;->pairReceiver:Landroid/content/BroadcastReceiver;

    const/4 v2, 0x4

    invoke-virtual {p0, v1, v0, v2}, Lcom/sk/keeper/MainActivity;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;I)Landroid/content/Intent;

    goto :goto_0

    .line 764
    :cond_1
    iget-object v1, p0, Lcom/sk/keeper/MainActivity;->pairReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v1, v0}, Lcom/sk/keeper/MainActivity;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    .line 766
    :goto_0
    return-void
.end method

.method private renderStatus(Ljava/lang/String;)V
    .locals 14

    .line 562
    const/4 v0, 0x3

    new-array v1, v0, [Ljava/lang/String;

    const-string v2, "sweep="

    invoke-static {p1, v2}, Lcom/sk/keeper/MainActivity;->field(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    aput-object v2, v1, v3

    const-string v2, "revive="

    invoke-static {p1, v2}, Lcom/sk/keeper/MainActivity;->field(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const/4 v4, 0x1

    aput-object v2, v1, v4

    const-string v2, "guard="

    invoke-static {p1, v2}, Lcom/sk/keeper/MainActivity;->field(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const/4 v5, 0x2

    aput-object v2, v1, v5

    .line 563
    const-string v2, "H="

    invoke-static {p1, v2}, Lcom/sk/keeper/MainActivity;->field(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 564
    const-string v6, "B="

    invoke-static {p1, v6}, Lcom/sk/keeper/MainActivity;->field(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 565
    const-string v7, "L="

    invoke-static {p1, v7}, Lcom/sk/keeper/MainActivity;->field(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 571
    nop

    .line 572
    move v7, v3

    move v8, v7

    :goto_0
    if-ge v7, v0, :cond_3

    .line 573
    aget-object v9, v1, v7

    invoke-virtual {v9}, Ljava/lang/String;->isEmpty()Z

    move-result v9

    if-nez v9, :cond_0

    .line 574
    iget-object v9, p0, Lcom/sk/keeper/MainActivity;->lastPids:[Ljava/lang/String;

    aget-object v10, v1, v7

    aput-object v10, v9, v7

    .line 575
    iget-object v9, p0, Lcom/sk/keeper/MainActivity;->missPolls:[I

    aput v3, v9, v7

    goto :goto_1

    .line 576
    :cond_0
    iget-object v9, p0, Lcom/sk/keeper/MainActivity;->missPolls:[I

    aget v10, v9, v7

    add-int/2addr v10, v4

    aput v10, v9, v7

    const/4 v9, 0x4

    if-ge v10, v9, :cond_1

    iget-object v10, p0, Lcom/sk/keeper/MainActivity;->lastPids:[Ljava/lang/String;

    aget-object v10, v10, v7

    invoke-virtual {v10}, Ljava/lang/String;->isEmpty()Z

    move-result v10

    if-nez v10, :cond_1

    .line 577
    iget-object v8, p0, Lcom/sk/keeper/MainActivity;->lastPids:[Ljava/lang/String;

    aget-object v8, v8, v7

    aput-object v8, v1, v7

    .line 578
    move v8, v4

    goto :goto_1

    .line 579
    :cond_1
    iget-object v10, p0, Lcom/sk/keeper/MainActivity;->missPolls:[I

    aget v10, v10, v7

    if-lt v10, v9, :cond_2

    .line 580
    iget-object v9, p0, Lcom/sk/keeper/MainActivity;->lastPids:[Ljava/lang/String;

    const-string v10, ""

    aput-object v10, v9, v7

    .line 572
    :cond_2
    :goto_1
    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    .line 584
    :cond_3
    aget-object v0, v1, v3

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_4

    aget-object v0, v1, v4

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_4

    aget-object v0, v1, v5

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_4

    move v0, v4

    goto :goto_2

    :cond_4
    move v0, v3

    .line 585
    :goto_2
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    .line 586
    const-string v9, "\u901a\u9053    "

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    iget-object v10, p0, Lcom/sk/keeper/MainActivity;->channelName:Ljava/lang/String;

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const/16 v10, 0xa

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 587
    const-string v9, "\u6e05\u7406    "

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    aget-object v11, v1, v3

    invoke-virtual {v11}, Ljava/lang/String;->isEmpty()Z

    move-result v11

    const-string v12, "\u672a\u8fd0\u884c"

    const-string v13, "pid "

    if-eqz v11, :cond_5

    move-object v3, v12

    goto :goto_3

    :cond_5
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    aget-object v3, v1, v3

    invoke-virtual {v11, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    :goto_3
    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v10}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 588
    const-string v3, "\u62c9\u8d77    "

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    aget-object v9, v1, v4

    invoke-virtual {v9}, Ljava/lang/String;->isEmpty()Z

    move-result v9

    if-eqz v9, :cond_6

    move-object v4, v12

    goto :goto_4

    :cond_6
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    aget-object v4, v1, v4

    invoke-virtual {v9, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    :goto_4
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v10}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 589
    const-string v3, "\u62e6\u622a    "

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    aget-object v4, v1, v5

    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-eqz v4, :cond_7

    goto :goto_5

    :cond_7
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    aget-object v1, v1, v5

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    :goto_5
    invoke-virtual {v3, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v10}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 590
    const-string v1, "\u5df2\u6e05    "

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    const-string v4, "0"

    if-eqz v3, :cond_8

    move-object v2, v4

    :cond_8
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " \u4e2a"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 591
    const-string v2, "   \u62e6\u4e0b "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v6}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_9

    move-object v6, v4

    :cond_9
    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " \u6b21\n"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 592
    const-string v1, "\u7535\u6c60    "

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->batteryOk()Z

    move-result v2

    if-eqz v2, :cond_a

    const-string v2, "\u4e0d\u53d7\u9650"

    goto :goto_6

    :cond_a
    const-string v2, "\u53d7\u9650\u5236(\u53ef\u80fd\u88ab\u540e\u53f0\u6e05\u6389)"

    :goto_6
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v10}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 593
    iget-boolean v1, p0, Lcom/sk/keeper/MainActivity;->isolated:Z

    if-eqz v1, :cond_b

    .line 594
    const-string v1, "\u9694\u79bb    \u65e0\u7ebf\u8c03\u8bd5\u5df2\u5173\u95ed, \u8f7d\u8377\u4ecd\u5728\u8dd1\n"

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 596
    :cond_b
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_c

    .line 597
    const-string v1, "\u6700\u8fd1    "

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p1}, Lcom/sk/keeper/MainActivity;->pretty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 599
    :cond_c
    iget-object p1, p0, Lcom/sk/keeper/MainActivity;->status:Landroid/widget/TextView;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 601
    if-eqz v0, :cond_f

    .line 603
    if-eqz v8, :cond_d

    const-string p1, "\u72b6\u6001\u5ef6\u8fdf"

    goto :goto_7

    :cond_d
    const-string p1, "\u8fd0\u884c\u4e2d"

    :goto_7
    if-eqz v8, :cond_e

    const v0, -0x1c4cbf

    goto :goto_8

    :cond_e
    const v0, -0xe93866

    :goto_8
    invoke-direct {p0, p1, v0}, Lcom/sk/keeper/MainActivity;->setBadge(Ljava/lang/String;I)V

    goto :goto_9

    .line 605
    :cond_f
    const-string p1, "\u8f7d\u8377\u672a\u89c1"

    const v0, -0x1ab7b3

    invoke-direct {p0, p1, v0}, Lcom/sk/keeper/MainActivity;->setBadge(Ljava/lang/String;I)V

    .line 607
    :goto_9
    return-void
.end method

.method private replyPendingIntent()Landroid/app/PendingIntent;
    .locals 3

    .line 793
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.sk.keeper.PAIR_REPLY"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/sk/keeper/MainActivity;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 799
    const/4 v1, 0x0

    const/high16 v2, 0xa000000

    invoke-static {p0, v1, v0, v2}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v0

    return-object v0
.end method

.method private resetIdle()V
    .locals 2

    .line 1194
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/sk/keeper/MainActivity;->busy:Z

    .line 1195
    const-string v0, "\u672a\u542f\u52a8"

    const v1, -0x907f6f

    invoke-direct {p0, v0, v1}, Lcom/sk/keeper/MainActivity;->setBadge(Ljava/lang/String;I)V

    .line 1196
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setEnabled(Z)V

    .line 1197
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    const-string v1, "\u5f00\u59cb\u6d4b\u8bd5"

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 1198
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->hint:Landroid/widget/TextView;

    const-string v1, "\u70b9\u4e0b\u9762\u7684\u6309\u94ae\u5f00\u59cb\u3002"

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 1199
    return-void
.end method

.method private roundRect(III)Landroid/graphics/drawable/GradientDrawable;
    .locals 2

    .line 249
    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    .line 250
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/GradientDrawable;->setShape(I)V

    .line 251
    const/16 v1, 0xc

    invoke-direct {p0, v1}, Lcom/sk/keeper/MainActivity;->dp(I)I

    move-result v1

    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    .line 252
    invoke-virtual {v0, p1}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 253
    if-lez p3, :cond_0

    .line 254
    invoke-direct {p0, p3}, Lcom/sk/keeper/MainActivity;->dp(I)I

    move-result p1

    invoke-virtual {v0, p1, p2}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    .line 256
    :cond_0
    return-object v0
.end method

.method private setBadge(Ljava/lang/String;I)V
    .locals 3

    .line 1223
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->badge:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u25cf "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 1224
    iget-object p1, p0, Lcom/sk/keeper/MainActivity;->badge:Landroid/widget/TextView;

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 1225
    return-void
.end method

.method private showEnableWireless()V
    .locals 4

    .line 646
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/sk/keeper/MainActivity;->busy:Z

    .line 647
    const-string v1, "\u5f85\u5f00\u542f"

    const v2, -0x1c4cbf

    invoke-direct {p0, v1, v2}, Lcom/sk/keeper/MainActivity;->setBadge(Ljava/lang/String;I)V

    .line 648
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 649
    const-string v2, "\u9700\u8981\u6253\u5f00\u65e0\u7ebf\u8c03\u8bd5"

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 650
    const-string v2, "\u8bbe\u7f6e \u2192 \u5f00\u53d1\u8005\u9009\u9879 \u2192 \u65e0\u7ebf\u8c03\u8bd5\n\n\u6253\u5f00\u540e\u8fd4\u56de\u672c\u9875, \u4f1a\u81ea\u52a8\u7ee7\u7eed\u3002"

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    new-instance v2, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda10;

    invoke-direct {v2, p0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda10;-><init>(Lcom/sk/keeper/MainActivity;)V

    .line 651
    const-string v3, "\u53bb\u6253\u5f00"

    invoke-virtual {v1, v3, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    new-instance v2, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda11;

    invoke-direct {v2, p0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda11;-><init>(Lcom/sk/keeper/MainActivity;)V

    .line 662
    const-string v3, "\u53d6\u6d88"

    invoke-virtual {v1, v3, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    .line 663
    invoke-virtual {v1, v0}, Landroid/app/AlertDialog$Builder;->setCancelable(Z)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 664
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 665
    return-void
.end method

.method private showPairDialog()V
    .locals 6

    .line 856
    invoke-virtual {p0}, Lcom/sk/keeper/MainActivity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 857
    return-void

    .line 859
    :cond_0
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 860
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 861
    const/16 v2, 0x14

    invoke-direct {p0, v2}, Lcom/sk/keeper/MainActivity;->dp(I)I

    move-result v3

    const/4 v4, 0x4

    invoke-direct {p0, v4}, Lcom/sk/keeper/MainActivity;->dp(I)I

    move-result v4

    invoke-direct {p0, v2}, Lcom/sk/keeper/MainActivity;->dp(I)I

    move-result v2

    const/4 v5, 0x0

    invoke-virtual {v0, v3, v4, v2, v5}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 867
    new-instance v2, Landroid/widget/EditText;

    invoke-direct {v2, p0}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    iput-object v2, p0, Lcom/sk/keeper/MainActivity;->pairEndpointView:Landroid/widget/EditText;

    .line 868
    iget-object v2, p0, Lcom/sk/keeper/MainActivity;->pairEndpointView:Landroid/widget/EditText;

    const/high16 v3, 0x41500000    # 13.0f

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->setTextSize(F)V

    .line 869
    iget-object v2, p0, Lcom/sk/keeper/MainActivity;->pairEndpointView:Landroid/widget/EditText;

    const-string v3, "IP:\u7aef\u53e3(\u81ea\u52a8\u53d1\u73b0, \u53d1\u73b0\u4e0d\u5230\u53ef\u624b\u586b)"

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    .line 870
    iget-object v2, p0, Lcom/sk/keeper/MainActivity;->pairEndpointView:Landroid/widget/EditText;

    invoke-virtual {v2, v1}, Landroid/widget/EditText;->setSingleLine(Z)V

    .line 871
    iget-object v2, p0, Lcom/sk/keeper/MainActivity;->pairEndpointView:Landroid/widget/EditText;

    invoke-virtual {v2, v1}, Landroid/widget/EditText;->setInputType(I)V

    .line 872
    iget-object v1, p0, Lcom/sk/keeper/MainActivity;->pairEndpointView:Landroid/widget/EditText;

    iget-object v2, p0, Lcom/sk/keeper/MainActivity;->pairingEp:Ljava/lang/String;

    invoke-virtual {v1, v2}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 873
    iget-object v1, p0, Lcom/sk/keeper/MainActivity;->pairEndpointView:Landroid/widget/EditText;

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 875
    new-instance v1, Landroid/widget/EditText;

    invoke-direct {v1, p0}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V

    .line 876
    const-string v2, "6 \u4f4d\u914d\u5bf9\u7801"

    invoke-virtual {v1, v2}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V

    .line 877
    const/4 v2, 0x2

    invoke-virtual {v1, v2}, Landroid/widget/EditText;->setInputType(I)V

    .line 878
    const/high16 v2, 0x41c00000    # 24.0f

    invoke-virtual {v1, v2}, Landroid/widget/EditText;->setTextSize(F)V

    .line 879
    const/16 v2, 0x11

    invoke-virtual {v1, v2}, Landroid/widget/EditText;->setGravity(I)V

    .line 880
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;

    .line 881
    const/16 v3, 0x44

    invoke-direct {p0, v3}, Lcom/sk/keeper/MainActivity;->dp(I)I

    move-result v3

    const/4 v4, -0x1

    invoke-direct {v2, v4, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 880
    invoke-virtual {v0, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 883
    new-instance v2, Landroid/app/AlertDialog$Builder;

    invoke-direct {v2, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 884
    const-string v3, "\u8f93\u5165\u914d\u5bf9\u7801"

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    .line 885
    const-string v3, "\u5728\u7cfb\u7edf\u5f39\u7a97\u300e\u4f7f\u7528\u914d\u5bf9\u7801\u914d\u5bf9\u8bbe\u5907\u300f\u91cc\u770b\u8fd9 6 \u4f4d\u6570\u5b57"

    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v2

    .line 886
    invoke-virtual {v2, v0}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 887
    const-string v2, "\u914d\u5bf9\u5e76\u542f\u52a8"

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v2, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda11;

    invoke-direct {v2, p0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda11;-><init>(Lcom/sk/keeper/MainActivity;)V

    .line 888
    const-string v3, "\u53d6\u6d88"

    invoke-virtual {v0, v3, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 889
    invoke-virtual {v0, v5}, Landroid/app/AlertDialog$Builder;->setCancelable(Z)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 890
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    .line 891
    new-instance v2, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda29;

    invoke-direct {v2, p0, v0, v1}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda29;-><init>(Lcom/sk/keeper/MainActivity;Landroid/app/AlertDialog;Landroid/widget/EditText;)V

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog;->setOnShowListener(Landroid/content/DialogInterface$OnShowListener;)V

    .line 905
    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    .line 906
    return-void
.end method

.method private static sleep(J)V
    .locals 0

    .line 1255
    :try_start_0
    invoke-static {p0, p1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1257
    goto :goto_0

    .line 1256
    :catch_0
    move-exception p0

    .line 1258
    :goto_0
    return-void
.end method

.method private startChannelService()V
    .locals 3

    .line 1173
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/sk/keeper/KeeperService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 1174
    nop

    .line 1175
    invoke-virtual {p0, v0}, Lcom/sk/keeper/MainActivity;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1181
    goto :goto_0

    .line 1179
    :catchall_0
    move-exception v0

    .line 1180
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[fgs] \u542f\u52a8\u5931\u8d25: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "Skeeper"

    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1182
    :goto_0
    return-void
.end method

.method private startDiscovery()V
    .locals 2

    .line 909
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->wireless:Lcom/sk/keeper/Wireless;

    if-eqz v0, :cond_0

    .line 910
    return-void

    .line 912
    :cond_0
    new-instance v0, Lcom/sk/keeper/Wireless;

    invoke-direct {v0, p0}, Lcom/sk/keeper/Wireless;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/sk/keeper/MainActivity;->wireless:Lcom/sk/keeper/Wireless;

    .line 913
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->wireless:Lcom/sk/keeper/Wireless;

    new-instance v1, Lcom/sk/keeper/MainActivity$2;

    invoke-direct {v1, p0}, Lcom/sk/keeper/MainActivity$2;-><init>(Lcom/sk/keeper/MainActivity;)V

    invoke-virtual {v0, v1}, Lcom/sk/keeper/Wireless;->start(Lcom/sk/keeper/Wireless$Listener;)V

    .line 931
    return-void
.end method

.method private startFlow(Z)V
    .locals 5

    .line 266
    iget-boolean v0, p0, Lcom/sk/keeper/MainActivity;->busy:Z

    if-eqz v0, :cond_0

    .line 267
    return-void

    .line 269
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/sk/keeper/MainActivity;->busy:Z

    .line 270
    iget-object v1, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setEnabled(Z)V

    .line 271
    iget-object v1, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    const-string v2, "\u6b63\u5728\u51c6\u5907\u2026"

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 272
    const-string v1, "\u51c6\u5907\u4e2d"

    const v2, -0x1c4cbf

    invoke-direct {p0, v1, v2}, Lcom/sk/keeper/MainActivity;->setBadge(Ljava/lang/String;I)V

    .line 282
    iget v1, p0, Lcom/sk/keeper/MainActivity;->flowSeq:I

    add-int/2addr v1, v0

    iput v1, p0, Lcom/sk/keeper/MainActivity;->flowSeq:I

    .line 283
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->ui:Landroid/os/Handler;

    new-instance v2, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda19;

    invoke-direct {v2, p0, v1}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda19;-><init>(Lcom/sk/keeper/MainActivity;I)V

    const-wide/32 v3, 0xafc8

    invoke-virtual {v0, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 289
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda20;

    invoke-direct {v1, p0, p1}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda20;-><init>(Lcom/sk/keeper/MainActivity;Z)V

    const-string p1, "sk-flow"

    invoke-direct {v0, v1, p1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 350
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 351
    return-void
.end method

.method private startPairNotify()V
    .locals 5

    .line 692
    invoke-virtual {p0}, Lcom/sk/keeper/MainActivity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 693
    return-void

    .line 695
    :cond_0
    const-class v0, Landroid/app/NotificationManager;

    invoke-virtual {p0, v0}, Lcom/sk/keeper/MainActivity;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    .line 696
    new-instance v1, Landroid/app/NotificationChannel;

    const-string v2, "\u914d\u5bf9\u8f93\u5165"

    const/4 v3, 0x3

    const-string v4, "pair_v2"

    invoke-direct {v1, v4, v2, v3}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    .line 698
    const-string v2, "\u5728\u901a\u77e5\u4e0a\u76f4\u63a5\u8f93\u5165\u65e0\u7ebf\u8c03\u8bd5\u914d\u5bf9\u7801"

    invoke-virtual {v1, v2}, Landroid/app/NotificationChannel;->setDescription(Ljava/lang/String;)V

    .line 699
    invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    .line 705
    invoke-virtual {v0}, Landroid/app/NotificationManager;->areNotificationsEnabled()Z

    move-result v0

    if-nez v0, :cond_1

    .line 706
    const-string v0, "\u901a\u77e5\u603b\u5f00\u5173\u662f\u5173\u7684: \u7cfb\u7edf\u8bbe\u7f6e\u2192\u5e94\u7528\u2192Keeper\u2192\u901a\u77e5\u91cc\u6253\u5f00, \u518d\u70b9\u5f00\u59cb\u6d4b\u8bd5\u3002"

    invoke-direct {p0, v0}, Lcom/sk/keeper/MainActivity;->post(Ljava/lang/String;)V

    .line 707
    const-string v0, "\u901a\u77e5\u88ab\u5173\u95ed, \u8f93\u7801\u6846\u51fa\u4e0d\u6765"

    invoke-direct {p0, v0}, Lcom/sk/keeper/MainActivity;->toast(Ljava/lang/String;)V

    .line 708
    return-void

    .line 711
    :cond_1
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x21

    if-lt v0, v1, :cond_2

    .line 712
    const-string v0, "android.permission.POST_NOTIFICATIONS"

    invoke-virtual {p0, v0}, Lcom/sk/keeper/MainActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_2

    .line 719
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->registerPairReceiver()V

    .line 720
    filled-new-array {v0}, [Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0x1b59

    invoke-virtual {p0, v0, v1}, Lcom/sk/keeper/MainActivity;->requestPermissions([Ljava/lang/String;I)V

    .line 722
    const-string v0, "\u8bf7\u5728\u5f39\u7a97\u91cc\u5141\u8bb8\u901a\u77e5 \u2014\u2014 \u8f93\u7801\u6846\u8981\u653e\u5728\u901a\u77e5\u680f\u91cc\u3002"

    invoke-direct {p0, v0}, Lcom/sk/keeper/MainActivity;->post(Ljava/lang/String;)V

    .line 723
    return-void

    .line 726
    :cond_2
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->registerPairReceiver()V

    .line 727
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\u7aef\u70b9 "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/sk/keeper/MainActivity;->pairingEp:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_3

    const-string v1, "\u53d1\u73b0\u4e2d\u2026"

    goto :goto_0

    :cond_3
    iget-object v1, p0, Lcom/sk/keeper/MainActivity;->pairingEp:Ljava/lang/String;

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n\u53bb\u7cfb\u7edf\u300e\u4f7f\u7528\u914d\u5bf9\u7801\u914d\u5bf9\u8bbe\u5907\u300f\u5f39\u7a97\u770b\u7801, \u62c9\u4e0b\u901a\u77e5\u680f\u8f93\u5165"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/sk/keeper/MainActivity;->pushPairNotification(Ljava/lang/String;)V

    .line 729
    const-string v0, "\u8f93\u5165\u6846\u5df2\u653e\u5230\u901a\u77e5\u680f\u3002\u53bb\u7cfb\u7edf\u8bbe\u7f6e\u6253\u5f00\u300e\u4f7f\u7528\u914d\u5bf9\u7801\u914d\u5bf9\u8bbe\u5907\u300f,\n\u770b\u5230 6 \u4f4d\u7801\u540e\u62c9\u4e0b\u901a\u77e5\u680f\u8f93\u5165 \u2014\u2014 \u7cfb\u7edf\u5f39\u7a97\u5168\u7a0b\u4e0d\u7528\u79bb\u5f00\u3002"

    invoke-direct {p0, v0}, Lcom/sk/keeper/MainActivity;->post(Ljava/lang/String;)V

    .line 731
    const-string v0, "\u8f93\u7801\u6846\u5728\u901a\u77e5\u680f\u91cc"

    invoke-direct {p0, v0}, Lcom/sk/keeper/MainActivity;->toast(Ljava/lang/String;)V

    .line 732
    return-void
.end method

.method private startPolling()V
    .locals 3

    .line 476
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->poller:Ljava/lang/Thread;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->poller:Ljava/lang/Thread;

    invoke-virtual {v0}, Ljava/lang/Thread;->isAlive()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 477
    return-void

    .line 479
    :cond_0
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda9;

    invoke-direct {v1, p0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda9;-><init>(Lcom/sk/keeper/MainActivity;)V

    const-string v2, "sk-poll"

    invoke-direct {v0, v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/sk/keeper/MainActivity;->poller:Ljava/lang/Thread;

    .line 558
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->poller:Ljava/lang/Thread;

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 559
    return-void
.end method

.method private stopChannelService()V
    .locals 2

    .line 1186
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/sk/keeper/KeeperService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Lcom/sk/keeper/MainActivity;->stopService(Landroid/content/Intent;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1188
    goto :goto_0

    .line 1187
    :catchall_0
    move-exception v0

    .line 1189
    :goto_0
    return-void
.end method

.method private stopPairNotify()V
    .locals 2

    .line 842
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->pairReceiver:Landroid/content/BroadcastReceiver;

    if-eqz v0, :cond_0

    .line 844
    :try_start_0
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->pairReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v0}, Lcom/sk/keeper/MainActivity;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 846
    goto :goto_0

    .line 845
    :catchall_0
    move-exception v0

    .line 847
    :goto_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sk/keeper/MainActivity;->pairReceiver:Landroid/content/BroadcastReceiver;

    .line 850
    :cond_0
    :try_start_1
    const-class v0, Landroid/app/NotificationManager;

    invoke-virtual {p0, v0}, Lcom/sk/keeper/MainActivity;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    const/16 v1, 0x1092

    invoke-virtual {v0, v1}, Landroid/app/NotificationManager;->cancel(I)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 852
    goto :goto_1

    .line 851
    :catchall_1
    move-exception v0

    .line 853
    :goto_1
    return-void
.end method

.method private toast(Ljava/lang/String;)V
    .locals 1

    .line 1228
    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    .line 1229
    return-void
.end method

.method private trySavedEndpoint()Z
    .locals 7

    .line 388
    const-string v0, "Skeeper"

    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v1

    const-string v2, "endpoint"

    const-string v3, ""

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 389
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    const/4 v3, 0x0

    if-eqz v2, :cond_0

    .line 390
    return v3

    .line 393
    :cond_0
    :try_start_0
    new-instance v2, Lcom/sk/keeper/AdbCli;

    invoke-direct {v2, p0}, Lcom/sk/keeper/AdbCli;-><init>(Landroid/content/Context;)V

    .line 394
    invoke-virtual {v2}, Lcom/sk/keeper/AdbCli;->install()Ljava/io/File;

    .line 395
    invoke-virtual {v2}, Lcom/sk/keeper/AdbCli;->canRun()Z

    move-result v4

    if-nez v4, :cond_1

    .line 396
    return v3

    .line 398
    :cond_1
    invoke-virtual {v2, v1}, Lcom/sk/keeper/AdbCli;->connect(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 399
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "[resume] connect "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " => "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v0, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 400
    const-string v5, "connected"

    invoke-virtual {v4, v5}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v4

    if-nez v4, :cond_2

    .line 401
    return v3

    .line 403
    :cond_2
    new-instance v4, Lcom/sk/keeper/AdbShell;

    invoke-direct {v4, v2, v1}, Lcom/sk/keeper/AdbShell;-><init>(Lcom/sk/keeper/AdbCli;Ljava/lang/String;)V

    .line 404
    const-string v1, "id"

    invoke-virtual {v4, v1}, Lcom/sk/keeper/AdbShell;->exec(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "uid=2000"

    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_3

    .line 405
    return v3

    .line 407
    :cond_3
    iput-object v4, p0, Lcom/sk/keeper/MainActivity;->shell:Lcom/sk/keeper/Shell;

    .line 408
    invoke-virtual {v4}, Lcom/sk/keeper/AdbShell;->label()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/sk/keeper/MainActivity;->channelName:Ljava/lang/String;

    .line 409
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->deployAndRun()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 410
    const/4 v0, 0x1

    return v0

    .line 411
    :catchall_0
    move-exception v1

    .line 412
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[resume] \u5931\u8d25: "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 413
    return v3
.end method

.method private updatePairNotification(Ljava/lang/String;)V
    .locals 0

    .line 838
    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->pushPairNotification(Ljava/lang/String;)V

    .line 839
    return-void
.end method

.method private waitForWireless(I)V
    .locals 4

    .line 668
    const/16 v0, 0x78

    if-gt p1, v0, :cond_2

    invoke-virtual {p0}, Lcom/sk/keeper/MainActivity;->isFinishing()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 672
    :cond_0
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->wirelessEnabled()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 673
    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->startFlow(Z)V

    .line 674
    return-void

    .line 676
    :cond_1
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->ui:Landroid/os/Handler;

    new-instance v1, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda12;

    invoke-direct {v1, p0, p1}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda12;-><init>(Lcom/sk/keeper/MainActivity;I)V

    const-wide/16 v2, 0x3e8

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 677
    return-void

    .line 669
    :cond_2
    :goto_0
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->resetIdle()V

    .line 670
    return-void
.end method

.method private wirelessEnabled()Z
    .locals 4

    .line 1233
    const/4 v0, 0x1

    :try_start_0
    invoke-virtual {p0}, Lcom/sk/keeper/MainActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    const-string v2, "adb_wifi_enabled"

    const/4 v3, 0x0

    invoke-static {v1, v2, v3}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-ne v1, v0, :cond_0

    goto :goto_0

    :cond_0
    move v0, v3

    :goto_0
    return v0

    .line 1234
    :catchall_0
    move-exception v1

    .line 1235
    return v0
.end method


# virtual methods
.method synthetic lambda$buildUi$0$com-sk-keeper-MainActivity(Landroid/view/View;)V
    .locals 2

    .line 194
    invoke-static {p0}, Lcom/sk/keeper/StopFlag;->remove(Landroid/content/Context;)V

    .line 195
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string v0, "armed"

    const/4 v1, 0x0

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 196
    invoke-direct {p0, v1}, Lcom/sk/keeper/MainActivity;->startFlow(Z)V

    .line 197
    return-void
.end method

.method synthetic lambda$buildUi$1$com-sk-keeper-MainActivity(Landroid/view/View;)V
    .locals 0

    .line 220
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->confirmIsolate()V

    return-void
.end method

.method synthetic lambda$buildUi$2$com-sk-keeper-MainActivity(Landroid/view/View;)V
    .locals 0

    .line 232
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->confirmExit()V

    return-void
.end method

.method synthetic lambda$confirmExit$26$com-sk-keeper-MainActivity(Landroid/content/DialogInterface;I)V
    .locals 0

    .line 1128
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->doEmergency()V

    return-void
.end method

.method synthetic lambda$confirmIsolate$23$com-sk-keeper-MainActivity(Landroid/content/DialogInterface;I)V
    .locals 0

    .line 1087
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->doIsolate()V

    return-void
.end method

.method synthetic lambda$degraded$5$com-sk-keeper-MainActivity(Ljava/lang/String;)V
    .locals 2

    .line 376
    const-string v0, "\u901a\u9053\u65ad\u5f00"

    const v1, -0x1c4cbf

    invoke-direct {p0, v0, v1}, Lcom/sk/keeper/MainActivity;->setBadge(Ljava/lang/String;I)V

    .line 377
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->hint:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 378
    iget-object p1, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setEnabled(Z)V

    .line 379
    iget-object p1, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    const-string v0, "\u6062\u590d\u901a\u9053"

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 380
    iget-object p1, p0, Lcom/sk/keeper/MainActivity;->status:Landroid/widget/TextView;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\u901a\u9053    \u5df2\u65ad\u5f00\n\u6e05\u7406    ?\n\u62c9\u8d77    ?\n\u62e6\u622a    ?\n\u5df2\u6e05    ?\n\u7535\u6c60    "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 381
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->batteryOk()Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "\u4e0d\u53d7\u9650"

    goto :goto_0

    :cond_0
    const-string v1, "\u53d7\u9650\u5236"

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 382
    iget-boolean v1, p0, Lcom/sk/keeper/MainActivity;->isolated:Z

    if-eqz v1, :cond_1

    const-string v1, "\n\u9694\u79bb    \u65e0\u7ebf\u8c03\u8bd5\u5df2\u5173\u95ed"

    goto :goto_1

    :cond_1
    const-string v1, ""

    :goto_1
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\n\u6700\u8fd1    \u8f7d\u8377\u4ecd\u5728 shell \u4fa7\u8fd0\u884c\uff0c\u53ea\u662f\u8fd9\u8fb9\u770b\u4e0d\u5230"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 380
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 384
    return-void
.end method

.method synthetic lambda$deployAndRun$6$com-sk-keeper-MainActivity(Ljava/lang/String;)V
    .locals 3

    .line 450
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setEnabled(Z)V

    .line 451
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    const-string v1, "\u91cd\u65b0\u90e8\u7f72"

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 452
    const-string v0, "\u8fd0\u884c\u4e2d"

    const v1, -0xe93866

    invoke-direct {p0, v0, v1}, Lcom/sk/keeper/MainActivity;->setBadge(Ljava/lang/String;I)V

    .line 453
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->hint:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u5df2\u542f\u52a8 \u00b7 "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 454
    return-void
.end method

.method synthetic lambda$deployAndRun$7$com-sk-keeper-MainActivity(Ljava/lang/String;)V
    .locals 0

    .line 464
    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->renderStatus(Ljava/lang/String;)V

    return-void
.end method

.method synthetic lambda$deployAndRun$8$com-sk-keeper-MainActivity()V
    .locals 3

    .line 462
    :try_start_0
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->shell:Lcom/sk/keeper/Shell;

    invoke-static {v0}, Lcom/sk/keeper/Payloads;->status(Lcom/sk/keeper/Shell;)Ljava/lang/String;

    move-result-object v0

    .line 463
    invoke-virtual {v0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    .line 464
    iget-object v1, p0, Lcom/sk/keeper/MainActivity;->ui:Landroid/os/Handler;

    new-instance v2, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda3;

    invoke-direct {v2, p0, v0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda3;-><init>(Lcom/sk/keeper/MainActivity;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 467
    :cond_0
    goto :goto_0

    .line 466
    :catchall_0
    move-exception v0

    .line 468
    :goto_0
    return-void
.end method

.method synthetic lambda$doEmergency$27$com-sk-keeper-MainActivity(Ljava/lang/String;)V
    .locals 2

    .line 1152
    const-string v0, "\u9000\u51fa\u5931\u8d25"

    const v1, -0x1ab7b3

    invoke-direct {p0, v0, v1}, Lcom/sk/keeper/MainActivity;->setBadge(Ljava/lang/String;I)V

    .line 1153
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->hint:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 1154
    iget-object p1, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setEnabled(Z)V

    .line 1155
    iget-object p1, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    const-string v0, "\u91cd\u8bd5\u9000\u51fa"

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 1156
    return-void
.end method

.method synthetic lambda$doEmergency$29$com-sk-keeper-MainActivity()V
    .locals 4

    .line 1163
    const-string v0, "\u5df2\u9000\u51fa"

    invoke-direct {p0, v0}, Lcom/sk/keeper/MainActivity;->toast(Ljava/lang/String;)V

    .line 1164
    invoke-virtual {p0}, Lcom/sk/keeper/MainActivity;->finishAndRemoveTask()V

    .line 1165
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    new-instance v1, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda27;

    invoke-direct {v1}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda27;-><init>()V

    const-wide/16 v2, 0x258

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 1167
    return-void
.end method

.method synthetic lambda$doEmergency$30$com-sk-keeper-MainActivity()V
    .locals 3

    .line 1138
    nop

    .line 1140
    :try_start_0
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->shell:Lcom/sk/keeper/Shell;

    invoke-static {p0, v0}, Lcom/sk/keeper/Payloads;->emergency(Landroid/content/Context;Lcom/sk/keeper/Shell;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1143
    goto :goto_0

    .line 1141
    :catchall_0
    move-exception v0

    .line 1142
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u7d27\u6025\u9000\u51fa\u5f02\u5e38: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1144
    :goto_0
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    .line 1149
    nop

    .line 1150
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[emergency] "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "Skeeper"

    invoke-static {v2, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 1151
    iget-object v1, p0, Lcom/sk/keeper/MainActivity;->ui:Landroid/os/Handler;

    new-instance v2, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda30;

    invoke-direct {v2, p0, v0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda30;-><init>(Lcom/sk/keeper/MainActivity;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 1157
    return-void

    .line 1159
    :cond_0
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/sk/keeper/MainActivity;->running:Z

    .line 1160
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    const-string v2, "armed"

    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    .line 1161
    const-string v2, "stopping"

    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 1162
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->ui:Landroid/os/Handler;

    new-instance v1, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda31;

    invoke-direct {v1, p0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda31;-><init>(Lcom/sk/keeper/MainActivity;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 1168
    return-void
.end method

.method synthetic lambda$doIsolate$24$com-sk-keeper-MainActivity(Ljava/lang/String;)V
    .locals 3

    .line 1108
    const-string v0, "\u5df2\u9694\u79bb"

    const v1, -0x1c4cbf

    invoke-direct {p0, v0, v1}, Lcom/sk/keeper/MainActivity;->setBadge(Ljava/lang/String;I)V

    .line 1109
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->hint:Landroid/widget/TextView;

    const-string v1, "\u65e0\u7ebf\u8c03\u8bd5\u5df2\u5173\u95ed, \u8f7d\u8377\u7ee7\u7eed\u5728 shell \u4fa7\u8fd0\u884c\u3002\n\u8981\u6062\u590d: \u7cfb\u7edf\u8bbe\u7f6e \u2192 \u5f00\u53d1\u8005\u9009\u9879 \u2192 \u65e0\u7ebf\u8c03\u8bd5, \u518d\u70b9\u5f00\u59cb\u6d4b\u8bd5\u3002"

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 1111
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setEnabled(Z)V

    .line 1112
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    const-string v1, "\u6062\u590d\u901a\u9053"

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 1113
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->status:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u901a\u9053    \u5df2\u9694\u79bb(\u65e0\u7ebf\u8c03\u8bd5\u5173\u95ed)\n\u8f7d\u8377    \u4ecd\u5728 shell \u4fa7\u8fd0\u884c\n\u7535\u6c60    "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 1115
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->batteryOk()Z

    move-result v2

    if-eqz v2, :cond_0

    const-string v2, "\u4e0d\u53d7\u9650"

    goto :goto_0

    :cond_0
    const-string v2, "\u53d7\u9650\u5236"

    :goto_0
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "\n\u7ed3\u679c    "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 1116
    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_1

    const-string p1, "-"

    goto :goto_1

    :cond_1
    invoke-static {p1}, Lcom/sk/keeper/MainActivity;->pretty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    :goto_1
    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 1113
    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 1117
    return-void
.end method

.method synthetic lambda$doIsolate$25$com-sk-keeper-MainActivity()V
    .locals 4

    .line 1096
    nop

    .line 1098
    :try_start_0
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->shell:Lcom/sk/keeper/Shell;

    invoke-static {p0, v0}, Lcom/sk/keeper/Payloads;->isolateWireless(Landroid/content/Context;Lcom/sk/keeper/Shell;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1101
    goto :goto_0

    .line 1099
    :catchall_0
    move-exception v0

    .line 1100
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u5f02\u5e38: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1102
    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[isolate] "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "Skeeper"

    invoke-static {v2, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 1103
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/sk/keeper/MainActivity;->isolated:Z

    .line 1104
    const/4 v2, 0x0

    iput-boolean v2, p0, Lcom/sk/keeper/MainActivity;->running:Z

    .line 1105
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v2

    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    const-string v3, "isolated"

    invoke-interface {v2, v3, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 1106
    nop

    .line 1107
    iget-object v1, p0, Lcom/sk/keeper/MainActivity;->ui:Landroid/os/Handler;

    new-instance v2, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda0;

    invoke-direct {v2, p0, v0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda0;-><init>(Lcom/sk/keeper/MainActivity;Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 1118
    return-void
.end method

.method synthetic lambda$fail$31$com-sk-keeper-MainActivity(Ljava/lang/String;)V
    .locals 2

    .line 1208
    const-string v0, "\u5931\u8d25"

    const v1, -0x1ab7b3

    invoke-direct {p0, v0, v1}, Lcom/sk/keeper/MainActivity;->setBadge(Ljava/lang/String;I)V

    .line 1209
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->hint:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 1210
    iget-object p1, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setEnabled(Z)V

    .line 1211
    iget-object p1, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    const-string v0, "\u91cd\u8bd5"

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 1212
    return-void
.end method

.method synthetic lambda$post$32$com-sk-keeper-MainActivity(Ljava/lang/String;)V
    .locals 1

    .line 1216
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->hint:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method synthetic lambda$showEnableWireless$16$com-sk-keeper-MainActivity(Landroid/content/DialogInterface;I)V
    .locals 0

    .line 653
    :try_start_0
    new-instance p1, Landroid/content/Intent;

    const-string p2, "android.settings.APPLICATION_DEVELOPMENT_SETTINGS"

    invoke-direct {p1, p2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, p1}, Lcom/sk/keeper/MainActivity;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 659
    goto :goto_0

    .line 654
    :catchall_0
    move-exception p1

    .line 656
    :try_start_1
    new-instance p1, Landroid/content/Intent;

    const-string p2, "android.settings.SETTINGS"

    invoke-direct {p1, p2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, p1}, Lcom/sk/keeper/MainActivity;->startActivity(Landroid/content/Intent;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 658
    goto :goto_0

    .line 657
    :catchall_1
    move-exception p1

    .line 660
    :goto_0
    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->waitForWireless(I)V

    .line 661
    return-void
.end method

.method synthetic lambda$showEnableWireless$17$com-sk-keeper-MainActivity(Landroid/content/DialogInterface;I)V
    .locals 0

    .line 662
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->resetIdle()V

    return-void
.end method

.method synthetic lambda$showPairDialog$20$com-sk-keeper-MainActivity(Ljava/lang/String;)V
    .locals 0

    .line 903
    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->pairAndDeploy(Ljava/lang/String;)V

    return-void
.end method

.method synthetic lambda$showPairDialog$21$com-sk-keeper-MainActivity(Landroid/widget/EditText;Landroid/app/AlertDialog;Landroid/view/View;)V
    .locals 1

    .line 893
    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    .line 894
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result p3

    const/4 v0, 0x6

    if-ge p3, v0, :cond_0

    .line 895
    const-string p1, "\u914d\u5bf9\u7801\u662f 6 \u4f4d\u6570\u5b57"

    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->toast(Ljava/lang/String;)V

    .line 896
    return-void

    .line 898
    :cond_0
    iget-object p3, p0, Lcom/sk/keeper/MainActivity;->pairEndpointView:Landroid/widget/EditText;

    invoke-virtual {p3}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p3

    .line 899
    invoke-virtual {p3}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    .line 900
    iput-object p3, p0, Lcom/sk/keeper/MainActivity;->pairingEp:Ljava/lang/String;

    .line 902
    :cond_1
    invoke-virtual {p2}, Landroid/app/AlertDialog;->dismiss()V

    .line 903
    new-instance p2, Ljava/lang/Thread;

    new-instance p3, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda13;

    invoke-direct {p3, p0, p1}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda13;-><init>(Lcom/sk/keeper/MainActivity;Ljava/lang/String;)V

    const-string p1, "sk-pair"

    invoke-direct {p2, p3, p1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    invoke-virtual {p2}, Ljava/lang/Thread;->start()V

    .line 904
    return-void
.end method

.method synthetic lambda$showPairDialog$22$com-sk-keeper-MainActivity(Landroid/app/AlertDialog;Landroid/widget/EditText;Landroid/content/DialogInterface;)V
    .locals 1

    .line 891
    const/4 p3, -0x1

    invoke-virtual {p1, p3}, Landroid/app/AlertDialog;->getButton(I)Landroid/widget/Button;

    move-result-object p3

    new-instance v0, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda8;

    invoke-direct {v0, p0, p2, p1}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda8;-><init>(Lcom/sk/keeper/MainActivity;Landroid/widget/EditText;Landroid/app/AlertDialog;)V

    .line 892
    invoke-virtual {p3, v0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 891
    return-void
.end method

.method synthetic lambda$startFlow$3$com-sk-keeper-MainActivity(I)V
    .locals 1

    .line 284
    iget-boolean v0, p0, Lcom/sk/keeper/MainActivity;->busy:Z

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/sk/keeper/MainActivity;->flowSeq:I

    if-ne p1, v0, :cond_0

    .line 285
    const-string p1, "\u90e8\u7f72\u8d85\u65f6(45 \u79d2)\u3002\u68c0\u67e5\u65e0\u7ebf\u8c03\u8bd5\u662f\u5426\u8fd8\u5f00\u7740, \u6216\u70b9\u91cd\u8bd5\u3002"

    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->fail(Ljava/lang/String;)V

    .line 287
    :cond_0
    return-void
.end method

.method synthetic lambda$startFlow$4$com-sk-keeper-MainActivity(Z)V
    .locals 3

    .line 291
    :try_start_0
    const-string v0, "\u67e5\u627e\u53ef\u7528\u901a\u9053\u2026"

    invoke-direct {p0, v0}, Lcom/sk/keeper/MainActivity;->post(Ljava/lang/String;)V

    .line 297
    const/16 v0, 0x2bc

    invoke-static {p0, v0}, Lcom/sk/keeper/LoopShell;->tryOpen(Landroid/content/Context;I)Lcom/sk/keeper/LoopShell;

    move-result-object v0

    .line 298
    if-nez v0, :cond_0

    .line 299
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->debugBridge()Lcom/sk/keeper/Shell;

    move-result-object v0

    .line 301
    :cond_0
    if-eqz v0, :cond_1

    .line 302
    iput-object v0, p0, Lcom/sk/keeper/MainActivity;->shell:Lcom/sk/keeper/Shell;

    .line 303
    invoke-interface {v0}, Lcom/sk/keeper/Shell;->label()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/sk/keeper/MainActivity;->channelName:Ljava/lang/String;

    .line 304
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->deployAndRun()V

    .line 305
    return-void

    .line 309
    :cond_1
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->wirelessEnabled()Z

    move-result v0

    if-nez v0, :cond_4

    .line 310
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->canWriteSecure()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 311
    const-string v0, "\u81ea\u52a8\u5f00\u542f\u65e0\u7ebf\u8c03\u8bd5\u2026"

    invoke-direct {p0, v0}, Lcom/sk/keeper/MainActivity;->post(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 313
    :try_start_1
    invoke-virtual {p0}, Lcom/sk/keeper/MainActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "adb_wifi_enabled"

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Landroid/provider/Settings$Global;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 315
    goto :goto_0

    .line 314
    :catchall_0
    move-exception v0

    .line 316
    :goto_0
    const-wide/16 v0, 0x4b0

    :try_start_2
    invoke-static {v0, v1}, Lcom/sk/keeper/MainActivity;->sleep(J)V

    .line 318
    :cond_2
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->wirelessEnabled()Z

    move-result v0

    if-nez v0, :cond_4

    .line 319
    if-eqz p1, :cond_3

    .line 320
    const-string p1, "\u65e0\u7ebf\u8c03\u8bd5\u5df2\u5173\u95ed\uff0c\u8f7d\u8377\u4ecd\u5728 shell \u4fa7\u8fd0\u884c\u3002\n\u70b9\u300c\u6062\u590d\u901a\u9053\u300d\u91cd\u65b0\u5f00\u542f\u5e76\u914d\u5bf9\u3002"

    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->degraded(Ljava/lang/String;)V

    .line 321
    return-void

    .line 323
    :cond_3
    const-string p1, "\u65e0\u7ebf\u8c03\u8bd5\u672a\u5f00\u542f"

    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->post(Ljava/lang/String;)V

    .line 324
    iget-object p1, p0, Lcom/sk/keeper/MainActivity;->ui:Landroid/os/Handler;

    new-instance v0, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda1;

    invoke-direct {v0, p0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda1;-><init>(Lcom/sk/keeper/MainActivity;)V

    invoke-virtual {p1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 325
    return-void

    .line 330
    :cond_4
    if-eqz p1, :cond_5

    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->trySavedEndpoint()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 331
    return-void

    .line 338
    :cond_5
    if-eqz p1, :cond_6

    .line 339
    const-string p1, "adb \u901a\u9053\u5df2\u65ad\u5f00\uff0c\u8f7d\u8377\u4ecd\u5728 shell \u4fa7\u8fd0\u884c\u3002\n\u70b9\u300c\u6062\u590d\u901a\u9053\u300d\u91cd\u65b0\u914d\u5bf9\u3002"

    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->degraded(Ljava/lang/String;)V

    .line 340
    return-void

    .line 344
    :cond_6
    const-string p1, "\u7b49\u5f85\u65e0\u7ebf\u8c03\u8bd5\u5e7f\u64ad\u2026"

    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->post(Ljava/lang/String;)V

    .line 345
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->startDiscovery()V

    .line 346
    iget-object p1, p0, Lcom/sk/keeper/MainActivity;->ui:Landroid/os/Handler;

    new-instance v0, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda2;

    invoke-direct {v0, p0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda2;-><init>(Lcom/sk/keeper/MainActivity;)V

    invoke-virtual {p1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 349
    goto :goto_1

    .line 347
    :catchall_1
    move-exception p1

    .line 348
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\u542f\u52a8\u5931\u8d25: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->fail(Ljava/lang/String;)V

    .line 350
    :goto_1
    return-void
.end method

.method synthetic lambda$startPolling$10$com-sk-keeper-MainActivity()V
    .locals 2

    .line 507
    const-string v0, "\u81ea\u52a8\u91cd\u90e8\u7f72\u4e2d"

    const v1, -0x1c4cbf

    invoke-direct {p0, v0, v1}, Lcom/sk/keeper/MainActivity;->setBadge(Ljava/lang/String;I)V

    return-void
.end method

.method synthetic lambda$startPolling$11$com-sk-keeper-MainActivity()V
    .locals 1

    .line 511
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->shell:Lcom/sk/keeper/Shell;

    invoke-static {v0}, Lcom/sk/keeper/Payloads;->status(Lcom/sk/keeper/Shell;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/sk/keeper/MainActivity;->renderStatus(Ljava/lang/String;)V

    return-void
.end method

.method synthetic lambda$startPolling$12$com-sk-keeper-MainActivity(Ljava/lang/String;)V
    .locals 3

    .line 515
    const-string v0, "\u8f7d\u8377\u672a\u89c1"

    const v1, -0x1ab7b3

    invoke-direct {p0, v0, v1}, Lcom/sk/keeper/MainActivity;->setBadge(Ljava/lang/String;I)V

    .line 516
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->hint:Landroid/widget/TextView;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u81ea\u52a8\u91cd\u90e8\u7f72\u5931\u8d25: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {p1}, Lcom/sk/keeper/MainActivity;->oneLine(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, "\n\u53ef\u70b9\u300c\u91cd\u65b0\u90e8\u7f72\u300d\u624b\u52a8\u518d\u8bd5\u3002"

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 518
    return-void
.end method

.method synthetic lambda$startPolling$15$com-sk-keeper-MainActivity()V
    .locals 11

    .line 480
    const-string v0, "sweep="

    const-string v1, "Skeeper"

    .line 481
    const/4 v2, 0x0

    move v3, v2

    move v4, v3

    .line 482
    :goto_0
    iget-boolean v5, p0, Lcom/sk/keeper/MainActivity;->running:Z

    if-eqz v5, :cond_9

    .line 484
    const-wide/16 v5, 0x7d0

    const/4 v7, 0x2

    :try_start_0
    iget-object v8, p0, Lcom/sk/keeper/MainActivity;->shell:Lcom/sk/keeper/Shell;

    if-nez v8, :cond_0

    .line 485
    goto/16 :goto_5

    .line 487
    :cond_0
    iget-object v8, p0, Lcom/sk/keeper/MainActivity;->shell:Lcom/sk/keeper/Shell;

    invoke-static {v8}, Lcom/sk/keeper/Payloads;->status(Lcom/sk/keeper/Shell;)Ljava/lang/String;

    move-result-object v8

    .line 488
    invoke-virtual {v8}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/String;->isEmpty()Z

    move-result v9

    if-eqz v9, :cond_1

    .line 489
    add-int/lit8 v3, v3, 0x1

    if-lt v3, v7, :cond_6

    .line 490
    iget-object v8, p0, Lcom/sk/keeper/MainActivity;->ui:Landroid/os/Handler;

    new-instance v9, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda14;

    invoke-direct {v9, p0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda14;-><init>(Lcom/sk/keeper/MainActivity;)V

    invoke-virtual {v8, v9}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_2

    .line 496
    :cond_1
    invoke-virtual {v8, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v9
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    if-nez v9, :cond_4

    add-int/lit8 v4, v4, 0x1

    const/4 v9, 0x4

    if-lt v4, v9, :cond_4

    .line 503
    nop

    .line 504
    :try_start_1
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v4

    const-string v8, "armed"

    invoke-interface {v4, v8, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v4

    if-nez v4, :cond_2

    .line 505
    move v4, v2

    goto :goto_0

    .line 507
    :cond_2
    iget-object v4, p0, Lcom/sk/keeper/MainActivity;->ui:Landroid/os/Handler;

    new-instance v8, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda15;

    invoke-direct {v8, p0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda15;-><init>(Lcom/sk/keeper/MainActivity;)V

    invoke-virtual {v4, v8}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 508
    const-string v4, "[poll] \u8f7d\u8377 8 \u79d2\u672a\u89c1, \u81ea\u52a8\u91cd\u65b0\u90e8\u7f72"

    invoke-static {v1, v4}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 509
    iget-object v4, p0, Lcom/sk/keeper/MainActivity;->shell:Lcom/sk/keeper/Shell;

    invoke-static {p0, v4}, Lcom/sk/keeper/Payloads;->deploy(Landroid/content/Context;Lcom/sk/keeper/Shell;)Ljava/lang/String;

    move-result-object v4

    .line 510
    const-string v8, "OK"

    invoke-virtual {v4, v8}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_3

    .line 511
    iget-object v4, p0, Lcom/sk/keeper/MainActivity;->ui:Landroid/os/Handler;

    new-instance v8, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda16;

    invoke-direct {v8, p0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda16;-><init>(Lcom/sk/keeper/MainActivity;)V

    invoke-virtual {v4, v8}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_1

    .line 513
    :cond_3
    nop

    .line 514
    iget-object v8, p0, Lcom/sk/keeper/MainActivity;->ui:Landroid/os/Handler;

    new-instance v9, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda17;

    invoke-direct {v9, p0, v4}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda17;-><init>(Lcom/sk/keeper/MainActivity;Ljava/lang/String;)V

    invoke-virtual {v8, v9}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 520
    :goto_1
    move v4, v2

    goto :goto_2

    .line 530
    :catchall_0
    move-exception v8

    move v4, v2

    goto :goto_3

    .line 521
    :cond_4
    nop

    .line 522
    :try_start_2
    invoke-virtual {v8, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_5

    .line 523
    move v4, v2

    .line 525
    :cond_5
    iget-object v3, p0, Lcom/sk/keeper/MainActivity;->ui:Landroid/os/Handler;

    new-instance v9, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda3;

    invoke-direct {v9, p0, v8}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda3;-><init>(Lcom/sk/keeper/MainActivity;Ljava/lang/String;)V

    invoke-virtual {v3, v9}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_2
    .catch Ljava/lang/InterruptedException; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move v3, v2

    .line 527
    :cond_6
    :goto_2
    :try_start_3
    invoke-static {v5, v6}, Ljava/lang/Thread;->sleep(J)V
    :try_end_3
    .catch Ljava/lang/InterruptedException; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    goto :goto_4

    .line 530
    :catchall_1
    move-exception v8

    move v3, v2

    goto :goto_3

    :catchall_2
    move-exception v8

    .line 537
    :goto_3
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "[poll] "

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-static {v1, v8}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 538
    add-int/lit8 v3, v3, 0x1

    if-lt v3, v7, :cond_7

    .line 539
    iget-object v7, p0, Lcom/sk/keeper/MainActivity;->ui:Landroid/os/Handler;

    new-instance v8, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda14;

    invoke-direct {v8, p0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda14;-><init>(Lcom/sk/keeper/MainActivity;)V

    invoke-virtual {v7, v8}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 545
    :cond_7
    const/16 v7, 0x96

    if-lt v3, v7, :cond_8

    .line 546
    const-string v0, "[poll] \u8fde\u7eed\u5931\u8d25 150 \u6b21, \u505c\u6b62\u8f6e\u8be2"

    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 547
    goto :goto_5

    .line 550
    :cond_8
    :try_start_4
    invoke-static {v5, v6}, Ljava/lang/Thread;->sleep(J)V
    :try_end_4
    .catch Ljava/lang/InterruptedException; {:try_start_4 .. :try_end_4} :catch_0

    .line 553
    nop

    .line 554
    :goto_4
    goto/16 :goto_0

    .line 551
    :catch_0
    move-exception v0

    .line 552
    goto :goto_5

    .line 528
    :catch_1
    move-exception v0

    .line 529
    nop

    .line 556
    :cond_9
    :goto_5
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sk/keeper/MainActivity;->poller:Ljava/lang/Thread;

    .line 557
    return-void
.end method

.method synthetic lambda$startPolling$9$com-sk-keeper-MainActivity()V
    .locals 2

    .line 491
    const-string v0, "\u901a\u9053\u65ad\u5f00"

    const v1, -0x1c4cbf

    invoke-direct {p0, v0, v1}, Lcom/sk/keeper/MainActivity;->setBadge(Ljava/lang/String;I)V

    .line 492
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setEnabled(Z)V

    .line 493
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->start:Landroid/widget/Button;

    const-string v1, "\u6062\u590d\u901a\u9053"

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 494
    return-void
.end method

.method synthetic lambda$waitForWireless$18$com-sk-keeper-MainActivity(I)V
    .locals 0

    .line 676
    add-int/lit8 p1, p1, 0x1

    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->waitForWireless(I)V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 4

    .line 108
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 109
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->buildUi()V

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x21

    if-lt v0, v1, :cond_notif_perm

    const-string v0, "android.permission.POST_NOTIFICATIONS"

    invoke-virtual {p0, v0}, Lcom/sk/keeper/MainActivity;->checkSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_notif_perm

    const/4 v0, 0x1

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "android.permission.POST_NOTIFICATIONS"

    aput-object v2, v0, v1

    const/16 v1, 0x64

    invoke-virtual {p0, v0, v1}, Lcom/sk/keeper/MainActivity;->requestPermissions([Ljava/lang/String;I)V

    :cond_notif_perm

    .line 112
    iget-object p1, p0, Lcom/sk/keeper/MainActivity;->ui:Landroid/os/Handler;

    new-instance v0, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda28;

    invoke-direct {v0, p0}, Lcom/sk/keeper/MainActivity$$ExternalSyntheticLambda28;-><init>(Lcom/sk/keeper/MainActivity;)V

    const-wide/16 v1, 0x2bc

    invoke-virtual {p1, v0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 114
    invoke-virtual {p0}, Lcom/sk/keeper/MainActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    const/4 v0, 0x1

    const/4 v1, 0x0

    if-eqz p1, :cond_0

    .line 115
    invoke-virtual {p0}, Lcom/sk/keeper/MainActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    const-string v2, "sk_revive"

    invoke-virtual {p1, v2, v1}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result p1

    if-eqz p1, :cond_0

    move p1, v0

    goto :goto_0

    :cond_0
    move p1, v1

    .line 118
    :goto_0
    if-eqz p1, :cond_1

    invoke-static {p0}, Lcom/sk/keeper/StopFlag;->pending(Landroid/content/Context;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 119
    const-string p1, "Skeeper"

    const-string v0, "[ui] \u68c0\u6d4b\u5230\u7d27\u6025\u9000\u51fa\u6807\u8bb0, \u76f4\u63a5\u7ed3\u675f"

    invoke-static {p1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 120
    invoke-virtual {p0}, Lcom/sk/keeper/MainActivity;->finish()V

    .line 121
    return-void

    .line 123
    :cond_1
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object v2

    const-string v3, "isolated"

    invoke-interface {v2, v3, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v2

    iput-boolean v2, p0, Lcom/sk/keeper/MainActivity;->isolated:Z

    .line 125
    if-nez p1, :cond_2

    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->prefs()Landroid/content/SharedPreferences;

    move-result-object p1

    const-string v2, "armed"

    invoke-interface {p1, v2, v1}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result p1

    if-eqz p1, :cond_3

    .line 126
    :cond_2
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->startChannelService()V

    .line 127
    iget-object p1, p0, Lcom/sk/keeper/MainActivity;->hint:Landroid/widget/TextView;

    const-string v1, "\u5b88\u62a4\u8fdb\u7a0b\u5df2\u628a\u5b83\u62c9\u56de\u6765, \u6b63\u5728\u6062\u590d\u901a\u9053\u2026"

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 128
    invoke-direct {p0, v0}, Lcom/sk/keeper/MainActivity;->startFlow(Z)V

    .line 130
    :cond_3
    return-void
.end method

.method protected onDestroy()V
    .locals 1

    .line 1262
    invoke-direct {p0}, Lcom/sk/keeper/MainActivity;->stopPairNotify()V

    .line 1263
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/sk/keeper/MainActivity;->running:Z

    .line 1264
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->wireless:Lcom/sk/keeper/Wireless;

    if-eqz v0, :cond_0

    .line 1265
    iget-object v0, p0, Lcom/sk/keeper/MainActivity;->wireless:Lcom/sk/keeper/Wireless;

    invoke-virtual {v0}, Lcom/sk/keeper/Wireless;->stop()V

    .line 1266
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/sk/keeper/MainActivity;->wireless:Lcom/sk/keeper/Wireless;

    .line 1268
    :cond_0
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    .line 1269
    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 0

    .line 771
    const/16 p2, 0x1b59

    if-eq p1, p2, :cond_0

    .line 772
    return-void

    .line 774
    :cond_0
    array-length p1, p3

    if-lez p1, :cond_2

    const/4 p1, 0x0

    aget p1, p3, p1

    if-nez p1, :cond_2

    .line 780
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p2, "\u7aef\u70b9 "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    iget-object p2, p0, Lcom/sk/keeper/MainActivity;->pairingEp:Ljava/lang/String;

    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result p2

    if-eqz p2, :cond_1

    const-string p2, "\u53d1\u73b0\u4e2d\u2026"

    goto :goto_0

    :cond_1
    iget-object p2, p0, Lcom/sk/keeper/MainActivity;->pairingEp:Ljava/lang/String;

    :goto_0
    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, "\n\u53bb\u7cfb\u7edf\u300e\u4f7f\u7528\u914d\u5bf9\u7801\u914d\u5bf9\u8bbe\u5907\u300f\u5f39\u7a97\u770b\u7801, \u62c9\u4e0b\u901a\u77e5\u680f\u8f93\u5165"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->pushPairNotification(Ljava/lang/String;)V

    .line 782
    const-string p1, "\u901a\u77e5\u5df2\u5c31\u7eea, \u62c9\u4e0b\u901a\u77e5\u680f\u8f93\u7801"

    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->toast(Ljava/lang/String;)V

    .line 783
    const-string p1, "\u901a\u77e5\u5df2\u5c31\u7eea\u3002\u53bb\u7cfb\u7edf\u8bbe\u7f6e\u6253\u5f00\u300e\u4f7f\u7528\u914d\u5bf9\u7801\u914d\u5bf9\u8bbe\u5907\u300f,\n\u770b\u5230 6 \u4f4d\u7801\u540e\u62c9\u4e0b\u901a\u77e5\u680f\u8f93\u5165\u3002"

    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->post(Ljava/lang/String;)V

    goto :goto_1

    .line 786
    :cond_2
    iget-object p1, p0, Lcom/sk/keeper/MainActivity;->hint:Landroid/widget/TextView;

    const-string p2, "\u6ca1\u6709\u901a\u77e5\u6743\u9650, \u901a\u77e5\u4e0a\u7684\u8f93\u7801\u6846\u51fa\u4e0d\u6765\u3002\n\u53bb \u7cfb\u7edf\u8bbe\u7f6e\u2192\u5e94\u7528\u2192Keeper\u2192\u901a\u77e5 \u6253\u5f00, \u518d\u70b9\u4e00\u6b21\u5f00\u59cb\u6d4b\u8bd5\u3002"

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 788
    const-string p1, "\u9700\u8981\u901a\u77e5\u6743\u9650"

    invoke-direct {p0, p1}, Lcom/sk/keeper/MainActivity;->toast(Ljava/lang/String;)V

    .line 790
    :goto_1
    return-void
.end method
