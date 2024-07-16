#!/bin/bash
echo "@testing https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
apk add sing-box@testing
apk add vim
