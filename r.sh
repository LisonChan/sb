#!/bin/bash

cat > /opt/realm/config.toml << EOF
[[endpoints]]
listen = "0.0.0.0:8080"
remote = "1.1.1.1:8080"
>EOF

cat > /etc/systemd/system/realm.service << EOF
[Unit]
Description=realm
After=network-online.target
Wants=network-online.target systemd-networkd-wait-online.service

[Service]
Type=simple
User=root
Restart=on-failure
RestartSec=5s
DynamicUser=true
ExecStart=/opt/realm/realm -c /opt/realm/config.toml

[Install]
WantedBy=multi-user.target
>EOF

vim /opt/realm/config.toml

chmod +x /opt/realm/realm

systemctl daemon-reload && systemctl enable realm && systemctl start realm && systemctl status realm
