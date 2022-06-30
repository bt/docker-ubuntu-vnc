#!/usr/bin/env bash
set -e

echo "Install Firefox"

add-apt-repository ppa:mozillateam/ppa
cat <<EOF > /etc/apt/preferences.d/firefox.pref
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
EOF

apt-get install firefox -y