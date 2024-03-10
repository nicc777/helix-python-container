ARG TAG=20.04
FROM docker.io/ubuntu:$TAG AS helix
ARG UID=1000
RUN apt update && apt upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt install -y nodejs npm python3 python3-pip python3-virtualenv software-properties-common tmux tmuxp tmux-plugin-manager tmuxinator dbus
RUN service dbus start
RUN npm install -y --location=global pyright

# TODO still need to install helix itself...
RUN add-apt-repository ppa:flatpak/stable
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install -y flatpak
# RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u $UID ubuntu
RUN flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
RUN flatpak install -y flathub com.helix_editor.Helix
# RUN su ubuntu -c flatpak install --user -y flathub com.helix_editor.Helix
#USER ubuntu
#RUN flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
#RUN flatpak install --user -y flathub com.helix_editor.Helix
RUN mkdir -p /data/workdir
WORKDIR /data/workdir
VOLUME /data/workdir

