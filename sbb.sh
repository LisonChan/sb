#!/bin/bash

# 给 singbox 启动脚本赋予执行权限
chmod +x /etc/init.d/singbox

# 将 singbox 服务添加到启动列表
rc-update add singbox default

# 启动 singbox 服务
service singbox start
