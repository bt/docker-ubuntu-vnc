#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

# prepare chromium if we install it
## Add Debian buster sources
cat <<EOF > /etc/apt/sources.list.d/debian.list
deb http://deb.debian.org/debian buster main
deb http://deb.debian.org/debian buster-updates main
deb http://deb.debian.org/debian-security buster/updates main
EOF

## Add Debian signing keys
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DCC9EFBF77E11517
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 648ACFD622F3D138
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys AA8E81B4331F7F50
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 112695A0E562B32A

## apt pinning
cat <<EOF > /etc/apt/preferences.d/chromium.pref
Package: *
Pin: release a=eoan
Pin-Priority: 500

Package: *
Pin: origin "deb.debian.org"
Pin-Priority: 300

# Pattern includes 'chromium', 'chromium-browser' and similarly
# named dependencies:
Package: chromium*
Pin: origin "deb.debian.org"
Pin-Priority: 700
EOF

# check if x86_64
if [[ $(uname -m) == "x86_64" ]]; then
	echo "Install Chrome Browser"
	apt-get update && apt-get install -y \
		apt-transport-https \
		ca-certificates \
		curl \
		gnupg \
		--no-install-recommends

	curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
	echo "deb https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

	apt-get update && apt-get install -y google-chrome-stable --no-install-recommends
	rm /home/user/Desktop/chromium.desktop
else
	echo "Install Chromium Browser"
	apt-get update && apt-get install -y chromium
	rm /home/user/Desktop/chrome.desktop
fi

rm -rf /var/lib/apt/lists/*
