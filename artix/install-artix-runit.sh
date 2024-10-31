#!/bin/sh

# add important groups
sudo usermod -aG video $(whoami) && sudo usermod -aG audio $(whoami) && sudo usermod -aG wheel $(whoami)

# remove irqbalance as it reduces performance
sudo pacman -Rnsudd irqbalance

# checking updates
sudo pacman -Syu --needed --noconfirm

# installing paru as a default AUR HELPER
sudo pacman -Syu --needed --noconfirm base-devel git && git clone --depth 1 https://aur.archlinux.org/paru-bin.git ~/stuffs/git/paru-bin && cd ~/stuffs/git/paru-bin && makepkg -si && echo "[bin]" | sudo tee -a ~/.config/paru/paru.conf > /dev/null

# installing important dependencies
paru -Syu --needed --noconfirm elogind-runit polkit dbus opendoas xorg linux-firmware pipewire pipewire-alsa pipewire-pulse pipewire-jack

# removing acpid and its service as it conflicts elogind
paru -Rnsudd --noconfirm acpid acpid-runit && sudo rm -rf /etc/runit/sv/acpid

# installing additional vulkan dependencies
paru -Syu --needed --noconfirm vulkan-icd-loader vulkan-swrast vulkan-mesa-layers

# 32bit vulkan dependencies [NEEDS MULTILIB REPO ENABLED]
#paru -Syu --needed --noconfirm lib32-vulkan-icd-loader lib32-vulkan-swrast lib32-vulkan-mesa-layers

# clone madand's runit-services (you have an option to enable this for the optimization and optional sections)
#git clone --depth 1 https://github.com/madand/runit-services.git ~/stuffs/git/runit-services


###### DRIVERS ######

# intel [NEEDS ARCH REPO ENABLED]
#paru -Syu --needed --noconfirm xf86-video-intel mesa vulkan-intel intel-media-driver libva-intel-driver libvdpau libvdpau-va-gl intel-media-sdk

# 32-bit intel [NEEDS MULTILIB REPO ENABLED]
#paru -Syu --needed --noconfirm lib32-mesa lib32-vulkan-intel lib32-libva-intel-driver lib32-libvdpau lib32-libvdpau-va-gl

# intel microcode [IMPORTANT]
#paru -Syu --needed --noconfirm intel-ucode

# modern_amd
#paru -Syu --needed --noconfirm xf86-video-amdgpu mesa vulkan-radeon libva-mesa-driver mesa-vdpau

# 32-bit modern_amd [NEEDS MULTILIB  ENABLED]
#paru -Syu --needed --noconfirm lib32-mesa lib32-vulkan-radeon lib32-libva-mesa-driver lib32-mesa-vdpau

# old_amd
#paru -Syu --needed --noconfirm xf86-video-ati mesa amdvlk libva-mesa-driver mesa-vdpau

# 32-bit old_amd [NEEDS MULTILIB REPO ENABLED]
#paru -Syu --needed --noconfirm lib32-mesa lib32-amdvlk lib32-libva-mesa-driver lib32-mesa-vdpau

# amd microcode [IMPORTANT]
#paru -Syu --needed --noconfirm amd-ucode

# 32-bit modern_nvidia open-source [NEEDS MULTILIB REPO ENABLED]
#paru -Syu --needed --noconfirm lib32-nvidia-utils

# modern_nvidia proprietary [NEEDS ARCH REPO ENABLED]
#paru -Syu --needed --noconfirm nvidia nvidia-dkms nvidia-utils libva-nvidia-driver

# 32-bit modern_nvidia proprietary [NEEDS MULTILIB REPO ENABLED]
#paru -Syu --needed --noconfirm lib32-nvidia-utils

# old_nvidia nouveau
#paru -Syu --needed --noconfirm xf86-video-nouveau mesa mesa-vdpau libva-mesa-driver vulkan-nouveau

# 32-bit old_nvidia nouveau [NEEDS MULTILIB REPO ENABLED]
#paru -Syu --needed --nouveau lib32-mesa lib32-mesa-vdpau lib32-libva-mesa-driver lib32-vulkan-nouveau

###### DRIVERS ######


###### OPTIONAL ######

# ttf-ms-fonts [LEGACY]
#paru -Syu --needed --noconfirm ttf-ms-fonts

# enable backlight service for saving previous brightness you've set after rebooting your pc
#paru -Syu --needed --noconfirm backlight-runit && sudo ln -s /etc/runit/sv/backlight/ /run/runit/service

# thinkfan [THINKPADS ONLY]
#sudo cp -r ~/stuffs/git/runit-services/thinkfan /etc/runit/sv/ && paru -Syu --needed --noconfirm thinkfan && sudo ln -s /etc/runit/sv/thinkfan/ /run/runit/service

# thermald (supports tlp) [INTEL ONLY]
#paru -Syu --needed --noconfirm thermald-runit 

# tlp
#paru -Syu --needed --noconfirm tlp-runit && sudo ln -s /etc/runit/sv/tlp/ /run/runit/service

# bluetooth
#paru -Syu --needed --noconfirm bluez-runit bluez-utils && sudo ln -s /etc/runit/sv/bluetoothd/ /run/runit/service

###### OPTIONAL ######


###### WINDOW MANAGERS ######

# bspwm (X11)
#paru -Syu --needed --noconfirm bspwm sxhkd polybar i3lock xorg-xinit xcolor xss-lock xsel xclip xdotool scrot rxvt-unicode

# hyprland (Wayland)
#paru -Syu --needed --noconfirm hyprland waybar hyprpicker hyprshot hyprlock xdg-desktop-portal-hyprland xdg-desktop-portal-gtk wl-clipboard foot

###### WINDOW MANAGERS ######


# install your programs here
paru -Syu --needed --noconfirm nwg-look noto-fonts noto-fonts-cjk noto-fonts-emoji dunst libnotify rofi rofi-calc rofi-emoji brightnessctl mpv nsxiv ranger zathura zathura-pdf-poppler  pavucontrol ufw acpi ueberzugpp ffmpegthumbnailer mate-polkit

# enable ufw with recommended settings by chris_titus
sudo ufw limit 22/tcp && sudo ufw allow 80/tcp && sudo ufw allow 443/tcp && sudo ufw default deny incoming && sudo ufw default allow outgoing && sudo ufw enable

# sudo alternative (doas) [RECOMMENDED]
sudo rm -f /etc/doas.conf && echo "permit persist :wheel" | sudo tee -a /etc/doas.conf > /dev/null

# remove any orphaned packages
paru -Rnsudd --noconfirm && paru -Sc --noconfirm

# removing sudo
paru -Rnsudd --noconfirm sudo
