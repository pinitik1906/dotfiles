#!/bin/bash

sudo xbps-install -Suv elogind seatd polkit dbus xorg-minimal xss-lock bspwm sxhkd i3lock polybar noto-fonts-ttf noto-fonts-emoji fastfetch xorg-fonts ueberzug rxvt-unicode neovim mpv pipewire bluez bluez-utils libspa-bluetooth udisks2 ranger ufw pavucontrol dunst rofi rofi-calc rofi-emoji xclip xdotool xtools linux-firmware-intel mesa-dri vulkan-loader mesa-vulkan-intel intel-video-accel brightnessctl feh zig gcc clang ffmpeg ffmpegthumbnailer opendoas scrot xrdb xcolor acpi

xcheckrestart

sudo ln -s /etc/sv/elogind /var/service/ && sudo ln -s /etc/sv/seatd /var/service && sudo ln -s /etc/sv/polkitd/ /var/service && sudo ln -s /etc/sv/dbus /var/service && sudo ln -s /etc/sv/ufw /var/service

sudo mkdir -p /etc/pipewire/pipewire.conf.d && sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/ && sudo mkdir -p /etc/pipewire/pipewire.conf.d && sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/

sudo ufw limit 22/tcp && sudo ufw allow 80/tcp && sudo ufw allow 443/tcp && sudo ufw default deny incoming && sudo ufw default allow outgoing && sudo ufw enable

sudo rm -f /etc/doas.conf && echo "permit $(whoami) as root" | sudo tee -a /etc/doas.conf > /dev/null && echo "permit :wheel" | sudo tee -a /etc/doas.conf > /dev/null 
