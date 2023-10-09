#!/bin/bash

# 获取当前脚本所在的文件夹路径
script_folder="$HOME/.scripts"

# 定义一个数组来存储需要排除的脚本名称
exclude_scripts=("loader.sh" "install.sh")

# 遍历文件夹中的所有脚本文件，排除指定的脚本
for script_file in "$script_folder"/*.sh; do
    # 获取脚本文件的基本名称
    script_name="$(basename "$script_file")"

    # 检查脚本名称是否在排除列表中
    if [[ ! " ${exclude_scripts[@]} " =~ " ${script_name} " ]]; then
        # 检查文件是否存在并且可执行
        if [ -f "$script_file" ] && [ -x "$script_file" ]; then
            echo "执行脚本: $script_file"
            # 执行脚本
            "$script_file"
        else
            echo "跳过非可执行文件: $script_file"
        fi
    fi
done

