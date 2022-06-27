---
layout: post
title: 制作mac启动盘
tag: mac installer startup
category: mac
---
# 下载mac完整的安装包
mac电脑可以用下边的命令来下载完整的mac安装包，`10.15.2`可以换成需求的版本，但有些版本可能不存在。
```bash
softwareupdate -d --fetch-full-installer --full-installer-version 10.15.2
```
# 制作启动盘
制作mac的启动安装盘，`/Volumes/Catalina`是插入U盘的位置
```bash
sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/Catalina
```
