#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install Xfce4 UI components"
apt-get update
apt-get install -y xfce4 xfce4-goodies xfce4-terminal xterm xfce4-clipman-plugin
apt-get purge -y pm-utils xscreensaver*
apt-get clean -y

echo "Disable screensaver"
rm -rf /etc/xdg/autostart/xscreensaver.desktop
rm -rf /etc/xdg/autostart/xfce4-screensaver.desktop