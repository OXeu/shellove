#!/bin/bash

# 定义 syncs 函数
syncs() {
    # 指定你的 .scripts 文件夹路径
    scripts_folder="$HOME/.scripts"

    # 检查 .scripts 文件夹是否存在
    if [ ! -d "$scripts_folder" ]; then
        echo "错误：.scripts 文件夹不存在。"
        return 1
    fi

    # 切换到 .scripts 文件夹
    cd "$scripts_folder" || return 1

    # 检查是否存在 git 仓库
    if [ ! -d ".git" ]; then
        echo "初始化 git 仓库..."
        git init
    fi

    # 添加所有文件到 git 仓库并提交更改
    git add .
    git commit 

    # 使用 git pull 来获取远程更改
    git pull origin master

    # 使用 git push 来上传本地更改
    git push origin master

    echo "同步完成。"
}
