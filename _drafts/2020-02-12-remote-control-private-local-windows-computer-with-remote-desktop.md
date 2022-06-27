---
layout: post
title: 用window自带的远程桌面连接内网window主机
tag: it remote window
category: it
---
# window主机开启远程控制
设置 -> 系统 -> 远程控制

# 设置ssh的端口转发
需要有一条可用的ssh隧道连接到内网

通过这条隧道在本地建立端口转发到需要连接的内网主机的3389端口

比如，下面的例子是用user@130.2.3.1:1234的ssh隧道，把本地的2222端口转发到内网192.168.1.130的3389端口
```bash
ssh -p 1234 -fqnN -L 2222:192.168.1.130:3389 user@130.2.3.1
```

# 使用window远程桌面连接
用远程桌面连接本地的转发端口，上例就是连接127.0.0.1:2222。

# 允许空密码用户进行远程桌面连接
默认空密码用户是不能进行远程桌面连接的，尝试连接时会出错，需要修改组策略。

1. 打开组策略编辑器，运行`GPEdit.msc`。
2. Local Computer Policy -> Computer Configuration -> Windows Settings -> Security Settings -> Local Policies -> Security Options
3. Locate Accounts: Limit local account use of blank passwords to console logon only，设置为Disabled。
