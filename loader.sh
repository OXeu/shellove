#!/bin/bash

# 获取当前脚本所在的文件夹路径
script_folder="$HOME/.scripts"

# 遍历文件夹中的所有脚本文件，排除 loader.sh 本身
for script_file in "$script_folder"/*.sh; do
    # 获取脚本文件的基本名称
    script_name="$(basename "$script_file")"

    # 排除 loader.sh 本身
    if [ "$script_name" != "loader.sh" ]; then
        # 检查文件是否存在并且可执行
        if [ -f "$script_file" ] && [ -x "$script_file" ]; then
            echo "Apply: $script_file"
            # 执行脚本
            source "$script_file"
        else
            echo "Skip: $script_file"
        fi
    fi
done
