---
layout: post
title: Unity包管理研究笔记
tag: unity package
category: unity
---

# 包服务器
使用 npm 的包管理系统

用 verdaccio 架设服务器

使用docker部署verdaccio服务器

## 配置
```yaml
...
auth:
  htpasswd:
    file: /verdaccio/storage/htpasswd
    # Maximum amount of users allowed to register, defaults to "+infinity".
    # You can set this to -1 to disable registration.
    max_users: -1
...
packages:
  '@*/*':
    # scoped packages
    access: $all
    publish: $authenticated
    unpublish: $authenticated
    # proxy: npmjs

  '**':
    # allow all users (including non-authenticated users) to read and
    # publish all packages
    #
    # you can specify usernames/groupnames (depending on your auth plugin)
    # and three keywords: "$all", "$anonymous", "$authenticated"
    access: $all

    # allow all known users to publish/publish packages
    # (anyone can register by default, remember?)
    publish: $authenticated
    unpublish: $authenticated
...
```

### 包管理
权限有三种：
- *access*，访问
- *publish*，发布
- *unpublish*，删除

可使用的组
- *all*，所有人
- *authenticaten*，登录的人
- *anonymous*，匿名用户

### 用户管理
`max_users`可以设置支持最大用户数，默认（不设置）为无限用户

客户端可以使用`npm login`来注册用户

`max_users`设置为*-1*，关闭用户功能

可以使用htpasswd命令来管理用户

- 添加用户，`htpasswd <passwd-file> <user-name>`，根据提示输入密码
- 删除用户，`htpasswd -D <passwd-file> <user-name>`

# 项目 manifest
位置： /<ProjectDir>/Packages/manifest.json/

使用 Scoped Package 设置不同包的 url

```json
{
    "scopedRegistries":
    [
        {
            "name": "Main",
            "url": "https://example.com/registry",
            "scopes":
            [
                "com.example", "com.example.tools.physics"
            ]
        },
        {
            "name": "Tools",
            "url": "https://mycompany.example.com/tools-registry",
            "scopes":
            [
                "com.example.mycompany.tools"
            ]
        }
    ],
    "dependencies": {
        "com.unity.animation": "1.0.0",
        "com.example.mycompany.tools.animation": "1.0.0",
        "com.example.tools.physics": "1.0.0",
        "com.example.animation": "1.0.0"
    }
}
```

# 自定义包
## 规则
- CHANGELOG https://keepachangelog.com/zh-CN/1.0.0/
- 语义化版本 https://semver.org/lang/zh-CN/

## 目录结构
- package.json
- README.md
- CHANGELOG.md
- LICENSE.md
- Editor
  - Unity.[YourPackageName].Editor.asmdef
  - EditorExample.cs
- Runtime
  - Unity.[YourPackageName].asmdef
  - RuntimeExample.cs
- Tests
  - Editor
    - Unity.[YourPackageName].Editor.Tests.asmdef
    - EditorExampleTest.cs
  - Runtime
    - Unity.[YourPackageName].Tests.asmdef
    - RuntimeExampleTest.cs
- Documentation~
  - [YourPackageName].md

## 代码
分 Runtime 和 Editor 放在顶层 Runtime 和 Editor 目录

## Package Manifest (package.json)

```json
{
    "name": "com.unity.example",
    "version": "1.2.3",
    "displayName": "Package Example",
    "description": "This is an example package",
    "unity": "2019.1",
    "unityRelease": "0b5",
    "dependencies": {
        "com.unity.some-package": "1.0.0",
        "com.unity.other-package": "2.0.0"
    },
    "keywords": [
        "keyword1",
        "keyword2",
        "keyword3"
    ],
    "author": {
        "name": "Unity",
        "email": "unity@example.com",
        "url": "https://www.unity3d.com"
    }
}
```

### name
格式 com.<company-name>.xxx.yyy

比如：
- com.company.ui.menumanage
- com.company.tool.terrain-exporter

### version
使用语义化版本

### displayName
简短的包名，显示再包列表界面

### description
包的简介，UTF-8 编码

### unity
兼容的最低 unity 版本

格式 <MAJOR>.<MINOR>

比如：
- 2019.2
- 2018.3
### unityRelease
unity 更新和发布的版本

格式 <UPDATE><RELEASE>

比如：
- Unity 版本号为 2019.2.21f
  - unity 为 2019.2
  - unityRelease 为 21f

### dependencies
依赖的包和版本

### keywords
标记包的 tag

## 上传包
要先登录npm的用户

使用`npm login --registry http://<npm-repo>:4873`，来注册用户

使用`npm publish --registry http://<npm-repo>:4873`，来发布包
