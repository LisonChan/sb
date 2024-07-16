#!/bin/bash

# 添加 testing 仓库
echo "@testing https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# 更新软件包列表
apk update

# 安装 sing-box
apk add sing-box@testing

# 安装 vim
apk add vim
