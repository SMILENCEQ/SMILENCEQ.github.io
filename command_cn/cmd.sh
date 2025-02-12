#!/bin/bash

# 定义常用命令的中文帮助信息
help_ls="ls 命令用于列出目录内容。常用选项：
  -l  详细格式列出文件信息
  -a  列出所有文件，包括隐藏文件
  -h  以人类可读的格式显示文件大小"

help_pwd="pwd 命令用于显示当前工作目录。"

# 根据传入的参数显示对应的帮助信息
case "$1" in
  ls)
    echo "$help_ls"
    ;;
  pwd)
    echo "$help_pwd"
    ;;
  *)
    echo "未知命令：$1"
    ;;
esac
