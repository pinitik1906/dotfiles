#!/bin/bash

sudo xbps-install -Su elogind seatd polkit dbus xorg-minimal xss-lock i3 i3lock polybar noto-fonts-ttf noto-fonts-emoji fastfetch xorg-fonts ueberzug alacritty neovim mpv pipewire bluez bluez-utils libspa-bluetooth udisks2 ranger ufw pavucontrol dunst dmenu linux-firmware-intel mesa-dri vulkan-loader mesa-vulkan-intel intel-video-accel brightnessctl feh zig gcc clang ffmpeg ffmpegthumbnailer

sudo ln -s /etc/sv/elogind /var/service/ && sudo ln -s /etc/sv/seatd /var/service && sudo ln -s /etc/sv/polkitd/ /var/service && sudo ln -s /etc/sv/dbus /var/service && sudo ln -s /etc/sv/ufw /var/service

sudo mkdir -p /etc/pipewire/pipewire.conf.d && sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/ && sudo mkdir -p /etc/pipewire/pipewire.conf.d && sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/

sudo ufw limit 22/tcp && sudo ufw allow 80/tcp && sudo ufw allow 443/tcp && sudo ufw default deny incoming && sudo ufw default allow outgoing && sudo ufw enable
