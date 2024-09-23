#!/bin/bash

sudo pacman -Syyu --needed base-devel git && git clone --depth 1 https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si

yay -Syyu --needed artix-archlinux-support xorg hyprland dunst swaylock mpv nsxiv ranger zathura zathura-pdf-poppler bluez bluez-runit bluez-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack pavucontrol xf86-video-intel mesa lib32-mesa vulkan-intel lib32-vulkan-intel libnotify ufw hyprshot hyprpicker

sudo ufw limit 22/tcp && sudo ufw allow 80/tcp && sudo ufw allow 443/tcp && sudo ufw default deny incoming && sudo ufw default allow outgoing && sudo ufw enable
