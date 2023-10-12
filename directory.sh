#!/bin/zsh -x

autoload -U compinit
compinit # 初始化补全

# 检查 ~/.scripts/data 目录是否存在，如果不存在则创建它
bookmarks_dir="$HOME/.scripts/data/bookmarks"
if [ ! -d "$bookmarks_dir" ]; then
    mkdir -p "$bookmarks_dir"
fi

# mark函数：将指定路径保存为指定名称的书签
mark() {
    local name="$1"
    local path="${2:-$(pwd)}"  # 如果没有提供 path 参数，则使用当前目录

    # 保存书签
    echo "$path" > "$bookmarks_dir/$name"
    echo "书签 '$name' 已保存: '$path'"
}

# cdm函数：切换至指定名称的目录
cdm() {
    local name="$1"
    local bookmark_file="$bookmarks_dir/$name"

    # 检查书签是否存在
    if [ -f "$bookmark_file" ]; then
        local path=$(cat $bookmark_file)
        cd "$path" || return 1 # 切换目录，如果失败则返回1
        echo "已切换至目录: $path"
    else
        echo "书签 '$name' 不存在"
        return 1  # 返回1表示失败
    fi
}

_cdm() {
    #local bookmarks_dir="$HOME/.scripts/data"
    local bookmarks=()
    # 获取所有书签的名称
    if [ -d "$bookmarks_dir" ]; then
        bookmarks=("$bookmarks_dir"/*)
        bookmarks=("${bookmarks[@]##*/}")  # 获取文件名部分
    fi
    
    _arguments \
        "1: :->bookmarks" \
        "*:: :->args"

    case "$state" in
        (bookmarks)
            _describe "bookmarks" bookmarks
            ;;
        (args)
            # 此处可以添加其他参数的自动补全规则，如果有的话
            ;;
    esac
}

compdef _cdm cdm

