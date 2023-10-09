#!/bin/bash

# 定义仓库地址
# 根据环境变量 SHELLOVE_TYPE 决定仓库地址
if [ "$SHELLOVE_TYPE" = "ssh" ]; then
    repository_url="git@github.com:ThankRain/shellove.git"
else
    repository_url="https://github.com/ThankRain/shellove.git"
fi

# 检查是否已经安装过脚本
if [ -d "$HOME/.scripts" ]; then
    echo "已经安装了脚本，跳过安装步骤。"
else
    # 克隆仓库到 $HOME/.scripts 文件夹
    git clone "$repository_url" "$HOME/.scripts"

    # 检查是否成功克隆仓库
    if [ $? -eq 0 ]; then
        echo "脚本成功安装到 $HOME/.scripts 文件夹。"
    else
        echo "安装脚本失败，请检查仓库地址和网络连接。"
        exit 1
    fi
fi

# 检查是否已经在 .profile 中添加了 source 命令
if ! grep -q "~/.scripts/loader.sh" "$HOME/.profile"; then
    # 将 source 命令追加到 .profile
    echo "source ~/.scripts/loader.sh" >> "$HOME/.profile"
    echo ".profile 中添加了 source 命令。"
else
    echo ".profile 中已经存在 source 命令，跳过添加步骤。"
fi

