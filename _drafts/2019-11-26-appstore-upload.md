---
layout: post
title: Transporter上传发布包工具
tag: ios appstore upload
category: mac
---
# 初见
更新XCode 11.2.1后App Loader工具从Xcode中移除，用独立的App Transporter来代替。

Transporter简洁易用，能显示上传的进度和各个阶段的信息，推荐使用。

# 问题
在换电脑后发现，在新的电脑上Transporter死活卡在*Anthenticating wth the App Store*阶段，用旧的电脑上传则没有问题。

# 解决
一顿Google之后，发现之前App Loader也类似的问题，有大神给出了解决方案：
```bash
cd ~
mv .itmstransporter/ .old_itmstransporter/
"/Applications/Xcode.app/Contents/Applications/Application Loader.app/Contents/itms/bin/itmstransporter"
```

结合一些其他的资料，分析如下：
- itmstransporter就是上传的工具，每次使用是它会自动检查并尝试更新版本
- 国内网络原因更新可能会失败，更新的缓存会在*.itmstransporter*目录中保存
- *Anthenticating wth the App Store*卡住可能因为某次工具更新失败，之后再使用是会尝试继续更新，但由于一些原因导致不能继续
- `mv .itmstransporter/ .old_itmstransporter/`相当于把itmstransporter更新的缓存清除，再次运行工具会自动重新开始更新

由于Transporter工具没有生成`.itmstransporter`目录，之后发现该App的Cache目录即为它的更新缓存目录。

# 方案
在使用Transporter时，如果发现在*Anthenticating wth the App Store*阶段卡很久。
1. 关闭Transporter
2. 清除itmstransporter更新缓存
```bash
mv ~/Library/Caches/com.apple.amp.itmstransporter ~/Library/Caches/com.apple.amp.itmstransporter_
```
3. 更新itmstransporter
```bash
/Applications/Transporter.app/Contents/itms/bin/iTMSTransporter
```
等它完成后返回，或者用`-version`参数可以等它打印出当前参数即完成，如有条件这个阶段可开VPN加快速度。
