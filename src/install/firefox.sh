#!/usr/bin/env bash
set -e

echo "Install Firefox"

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A6DCF7707EBC211F
apt-add-repository "deb http://ppa.launchpad.net/ubuntu-mozilla-security/ppa/ubuntu focal main"
