#!/bin/bash

# only for glibc systems (enabling nonfree and multilib repos)
# sudo xbps-install -Suv void-repo-nonfree void-repo-multilib void-repo-mulitilib-nonfree

# these are not from the free repos
# sudo -Suv intel-ucode mesa-dri-32bit

sudo xbps-install -Suv elogind seatd polkit dbus xorg-minimal xorg-fonts xrdb xcolor xf86-video-intel linux-firmware-intel linux-headers mesa-dri vulkan-loader mesa-vulkan-intel intel-video-accel pipewire bluez bluez-utils libspa-bluetooth base-devel xss-lock bspwm sxhkd i3lock noto-fonts-ttf noto-fonts-emoji noto-fonts-cjk fastfetch ueberzug rxvt-unicode neovim mpv udisks2 ranger ufw pavucontrol dunst rofi rofi-calc rofi-emoji xsel xclip xdotool xtools brightnessctl nsxiv zig gcc clang ffmpeg ffmpegthumbnailer opendoas scrot acpi

sudo ln -s /etc/sv/elogind /var/service/ && sudo ln -s /etc/sv/seatd /var/service && sudo ln -s /etc/sv/polkitd/ /var/service && sudo ln -s /etc/sv/dbus /var/service && sudo ln -s /etc/sv/ufw /var/service

sudo mkdir -p /etc/pipewire/pipewire.conf.d && sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/ && sudo mkdir -p /etc/pipewire/pipewire.conf.d && sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/

sudo ufw limit 22/tcp && sudo ufw allow 80/tcp && sudo ufw allow 443/tcp && sudo ufw default deny incoming && sudo ufw default allow outgoing && sudo ufw enable

sudo rm -f /etc/doas.conf && echo "permit $(whoami) as root" | sudo tee -a /etc/doas.conf > /dev/null && echo "permit :wheel" | sudo tee -a /etc/doas.conf > /dev/null

xcheckrestart
