#!/bin/bash

# 安装 sing-box
echo "@testing https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && apk update && apk add sing-box@testing && apk add vim

# 上传配置文件
wget -P /root/ https://raw.githubusercontent.com/LisonChan/sb/main/config.json

# 设置自启
cat > /etc/init.d/singbox << EOF
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
chmod +x /etc/init.d/singbox && rc-update add singbox default && service singbox start
