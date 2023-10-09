# Shellove
增强 Shell 体验的常用脚本集合

# 安装
1. Fork 本仓库

2. 执行以下命令
```shell
bash <(curl -s https://raw.githubusercontent.com/ThankRain/shellove/master/install.sh)
```

3. 输入您的仓库克隆地址（HTTPS/SSH）

4. Enjoy it!

# 基础命令

## 书签

### 添加书签

```shell
$ mark <name> [path]
```
`<name>`: 书签名称
`[path]`: (可选)书签路径，默认为当前目录

### 跳转书签
支持自动补全
```shell
$ cdm <name>
```
`<name>`: 书签名称

## Git
### Gitgraph
`git log --all --graph --decorate` 的短命令
```shell
$ gitgraph
$ # 或
$ gg
```

## 其他
### 持久化环境变量
将指定路径添加到环境变量 `PATH` 中，并将其持久化至 `~/.scripts/env.sh` 中
```shell
$ addpath [path]
```
`[path]` 需要添加到 `PATH` 的路径，默认为当前路径

## 自定义脚本

1. 在 `~/.scripts` 文件夹中编写新脚本

2. `chmod +x xx.sh` 为其添加可执行权限

3. `rld` 重新加载所有脚本

4. `syncs` 输入 commit 信息，并同步到自己仓库中