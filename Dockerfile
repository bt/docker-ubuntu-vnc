# This Dockerfile is used to build an headless vnc image based on Ubuntu
FROM ubuntu:22.04

## Connection ports for controlling the UI:
# VNC port:5901 HTTP port:6901
ENV DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6901

# Arguments if provided
ARG VNC_PW=vncpassword
ARG VNC_RESOLUTION=1920x1080

EXPOSE $VNC_PORT $NO_VNC_PORT

### Envrionment config
ENV HOME=/home/user \
    TERM=xterm \
    STARTUPDIR=/dockerstartup \
    INST_SCRIPTS=/headless/install \
    NO_VNC_HOME=/headless/noVNC \
    DEBIAN_FRONTEND=noninteractive \
    VNC_COL_DEPTH=24 \
    VNC_PW=$VNC_PW \
    VNC_RESOLUTION=$VNC_RESOLUTION \
    VNC_VIEW_ONLY=false


WORKDIR $INST_SCRIPTS

### Setup user
RUN useradd -u 1000 -m -s /bin/bash -G sudo user
ADD ./src/xfce/ /home/user

### Update OS
ADD src/install/update_os.sh .
RUN ./update_os.sh

### Install some common tools
ADD src/install/tools.sh .
RUN ./tools.sh
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

### Install custom fonts
ADD src/install/install_custom_fonts.sh .
RUN ./install_custom_fonts.sh

### Install vnc-server and novnc
ADD src/install/tigervnc.sh .
RUN ./tigervnc.sh
ADD src/install/novnc.sh .
RUN ./novnc.sh

### Install xfce UI
ADD src/install/xfce_ui.sh .
RUN $INST_SCRIPTS/xfce_ui.sh

### Install firefox and chrome browser
ADD src/install/firefox.sh .
RUN $INST_SCRIPTS/firefox.sh

ADD src/install/chrome.sh .
RUN $INST_SCRIPTS/chrome.sh

ADD src/install/set_user_permission.sh .
RUN ./set_user_permission.sh

### configure startup
ADD src/scripts $STARTUPDIR

WORKDIR /home/user
USER 1000

ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]
CMD ["--wait"]
