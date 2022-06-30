#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install some common tools for further installation"
apt-get update
apt-get install -y vim wget net-tools locales bzip2 sudo software-properties-common git jq xclip claws-mail xvkbd libreoffice
apt-get clean -y

echo "Generate locales for en_US.UTF-8"
locale-gen en_US.UTF-8
