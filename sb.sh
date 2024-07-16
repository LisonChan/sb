#!/bin/bash

# 添加 testing 仓库
echo "@testing https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# 更新软件包列表
apk update

# 安装 sing-box
apk add sing-box@testing

# 设置自启
cat > /root/sb << EOF
#!/sbin/openrc-run
 
command="/usr/bin/sing-box"
command_args="run -c /root/config.json" #是您的配置文件位置
description="singbox service"
 
depend() {
  need net
  use logger
}
 
start() {
  ebegin "Starting singbox"
  start-stop-daemon --start --background --exec $command -- $command_args
  eend $?
}
 
stop() {
  ebegin "Stopping singbox"
  start-stop-daemon --stop --exec $command
  eend $?
}
EOF

# 给 singbox 启动脚本赋予执行权限
chmod +x /etc/init.d/singbox

# 将 singbox 服务添加到启动列表
rc-update add singbox default

# 启动 singbox 服务
service singbox start
