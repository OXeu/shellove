#!/bin/bash

# 获取脚本所在文件夹的路径
script_folder="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 定义 env_file 变量以保存 env.sh 文件的路径
env_file="$script_folder/env.sh"

# 定义 addpath 函数
addpath() {
    local new_path="$1"
    
    # 如果没有传递参数，则使用当前目录作为默认路径
    if [ -z "$new_path" ]; then
        new_path="$(pwd)"
    fi
    
    # 使用 readlink 命令获取绝对路径
    new_path="$(readlink -f "$new_path")"
    
    # 检查是否已经存在在PATH中
    if [[ ":$PATH:" != *":$new_path:"* ]]; then
        # 将新路径添加到PATH中
        export PATH="$new_path:$PATH"
        # 将PATH写入 env.sh 文件
        echo "export PATH=\"$new_path:\$PATH\"" >> "$env_file"
        echo "已添加路径 '$new_path' 到 PATH 变量中"
    else
        echo "路径 '$new_path' 已经在 PATH 变量中"
    fi
}
