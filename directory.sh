#!/bin/zsh 

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

dir_stack=()

# cdm函数：切换至指定名称的目录
cdm() {
    dir_stack+=("$(pwd)")
    local name="$1"
    local bookmark_file="$bookmarks_dir/$name"
    # 检查书签是否存在
    if [ -f "$bookmark_file" ]; then
        local p="$(cat $bookmark_file)"
        cd "$p" # 切换目录，如果失败则返回1
        echo "已切换至目录: $p"
    else
        echo "书签 '$name' 不存在"
        return 1  # 返回1表示失败
    fi
}

# 自定义函数 ex，用于退出目录并返回到之前的目录
ex() {
  # 如果堆栈为空，输出提示信息
  if [ ${#dir_stack[@]} -eq 0 ]; then
    echo "No directory to return to."
    return 1
  fi

  # 获取堆栈的顶部元素
  previous_dir="${dir_stack[@]: -1}"
  # 使用 cd 命令返回到之前的目录
  cd "$previous_dir"

  # 从堆栈中移除最顶部的元素
  dir_stack[-1]=()

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

