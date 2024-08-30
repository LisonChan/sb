#!/bin/bash

apt update && bash <(curl -fsSL https://sing-box.app/deb-install.sh)

wget -P /etc/sing-box/ https://raw.githubusercontent.com/LisonChan/sb/main/config.json

vim /etc/sing-box/config.json

systemctl start sing-box
