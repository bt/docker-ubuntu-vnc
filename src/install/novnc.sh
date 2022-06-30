#!/usr/bin/env bash
set -e
set -u

echo "Install noVNC"
mkdir -p $NO_VNC_HOME
wget -qO- https://github.com/novnc/noVNC/archive/v1.3.0.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME

# install websockify
git clone https://github.com/novnc/websockify $NO_VNC_HOME/utils/websockify

## create index.html to forward automatically to `vnc.html`
ln -s $NO_VNC_HOME/vnc.html $NO_VNC_HOME/index.html