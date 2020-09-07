# 代码自动拉取脚本使用教程

### 生成ssh key

在编写脚本之前确保服务器有权限拉取github代码，如果已经做了配置可跳过本节去看部署脚本编写。ssh key是代码托管平台（github、gitee、coding、gitlab等）鉴别你是否有权拉取代码的身份标识，生成只需一行命令和一路回车就行了.

```
ssh-keygen
```
```
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /root/.ssh/id_rsa.
Your public key has been saved in /root/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:M6sCf/J/hOu3zLxMkFUVmv3iWIa30CfbxiWqmWCt1YE root@iZwz96y36tk2ecnykzituxZ
The key's randomart image is:
+---[RSA 2048]----+
|            ..o. |
|           . o   |
|          . o    |
|       . o .     |
|      E S.  .    |
|  .  . ..Oo ..   |
|   oo o ==Boo .  |
|   .++.+o#== .   |
|    .=*+=+@o     |
+----[SHA256]-----+

```
生成后可通过cat ~/.ssh/id_rsa.pub命令查看，最后将key加入github即可。
```
cat ~/.ssh/id_rsa.pub

ssh-rsa AAAAB3NzaC1yc2EAAAADAQHBAAABAQCv7LGVJUFdcLL+HZyRFTQIQCdre61Gch76lDVpmWSX9BGGRU3iQS7EU5qApFn1VSvt+yf4rMt2LEkuxGCm1wIyBKZ6LYDViZBeTAfx4BcM1mcpxOX6I/+r07mQ4llTz+poQB1Zp9Y60uk0tbGOVWlCoDBEvf9qeEnQ0qEczEkv7wcawV6pVhlXjFKZgq0EOQbCYoWMvPUl+dwDbTcl/h+7At1nlgfF7IuRHlKf18qvgnTRT2wpiuz4pWdoAi8LcY1JiR1z5OB0oCJ2euhyDND39G2NxZRS1FIVdgCEvioHtdoHOSoWBlcSj0fLFSnscBfRBrCd7yhOP7fFKfrowHMj root@iZwz96y36tk2ecnykzituxZ

```

### 修改sh目录中的脚本

该shell脚本的主要目的是从github拉取代码，脚本内容很简单，只做了目录的简要判断，代码目录存在则更新，不存在则克隆仓库，工作目录和仓库名称、地址请换成对应的。

### webhook配置与启动

编写配置文件webhook目录中的 hooks.json，格式如下。
```
[
  {
    "id": "deploy-webhook",
    "execute-command": "deploy.sh",
    "command-working-directory": "/home"
  }
]
```

1. id：钩子的id，可自定义
2. execute-command：要执行的脚本名，就是刚才编写的部署脚本
3. command-working-directory：脚本所在目录

### 启动webhook 

```
./webhook -hooks hooks.json -verbose

[webhook] 2020/04/22 15:18:22 version 2.6.11 starting
[webhook] 2020/04/22 15:18:22 setting up os signal watcher
[webhook] 2020/04/22 15:18:22 attempting to load hooks from hooks.json
[webhook] 2020/04/22 15:18:22 found 1 hook(s) in file
[webhook] 2020/04/22 15:18:22   loaded: deploy-webhook
[webhook] 2020/04/22 15:18:22 serving hooks on http://0.0.0.0:9000/hooks/{id}
[webhook] 2020/04/22 15:18:22 os signal watcher ready

```

### Github Webhooks配置
现在服务器已经启动了webhook程序监听9000端口，接下来仅需要告诉Github这个地址和端口就好了。打开仓库设置页，添加webhook。




