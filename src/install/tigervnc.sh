#!/usr/bin/env bash
set -e

echo "Install TigerVNC server"

if [[ $(uname -m) == "aarch64" ]]; then
    URL="https://sourceforge.net/projects/tigervnc/files/stable/1.12.0/ubuntu-20.04LTS/arm64/tigervncserver_1.12.0-1ubuntu1_arm64.deb/download"
else
    URL="https://sourceforge.net/projects/tigervnc/files/stable/1.12.0/ubuntu-20.04LTS/amd64/tigervncserver_1.12.0-1ubuntu1_amd64.deb/download"
fi

wget -O tigervnc_server.deb $URL
dpkg -i tigervnc_server.deb
rm tigervnc_server.deb