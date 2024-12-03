#!/bin/sh

# add important groups
sudo usermod -aG video,audio,wheel,vboxusers $(whoami)

# checking updates, syncing repos and installing opendoas
sudo pacman -Syu --needed --noconfirm opendoas

# copying preconfigured pacman.conf and paru.conf
sudo pacman -S --needed --noconfirm artix-archlinux-support && sudo cp -r ~/stuffs/git/dotfiles/artix/pacman.conf /etc/pacman.conf && sudo cp -r ~/stuffs/git/dotfiles/artix/paru.conf /etc/paru.conf

# installing paru as a default AUR HELPER
sudo pacman -S --needed --noconfirm base-devel git && git clone --depth 1 https://aur.archlinux.org/paru-bin.git ~/stuffs/git/paru-bin && cd ~/stuffs/git/paru-bin && makepkg -si 

# installing important dependencies
paru -Rnsudd --noconfirm jack2 && paru -S --needed --noconfirm base-devel elogind-runit polkit dbus xorg linux-firmware pipewire pipewire-alsa pipewire-pulse pipewire-jack mate-polkit ffmpeg playerctl less mandoc ttf-inconsolata

# removing acpid and its service as it conflicts elogind
paru -Rnsudd --noconfirm acpid acpid-runit && sudo rm -rf /etc/runit/sv/acpid

# installing additional vulkan dependencies
paru -S --needed --noconfirm vulkan-icd-loader vulkan-swrast vulkan-mesa-layers

# 32bit vulkan dependencies [NEEDS MULTILIB REPO ENABLED]
#paru -S --needed --noconfirm lib32-vulkan-icd-loader lib32-vulkan-swrast lib32-vulkan-mesa-layers


###### DRIVERS ######

# intel [NEEDS ARCH REPO ENABLED]
#paru -S --needed --noconfirm xf86-video-intel mesa vulkan-intel intel-media-driver libva-intel-driver libvdpau libvdpau-va-gl intel-media-sdk

# 32-bit intel [NEEDS MULTILIB REPO ENABLED]
#paru -S --needed --noconfirm lib32-mesa lib32-vulkan-intel lib32-libva-intel-driver lib32-libvdpau lib32-libvdpau-va-gl

# intel microcode [IMPORTANT]
#paru -S --needed --noconfirm intel-ucode

# modern_amd
#paru -S --needed --noconfirm xf86-video-amdgpu mesa vulkan-radeon libva-mesa-driver mesa-vdpau

# 32-bit modern_amd [NEEDS MULTILIB  ENABLED]
#paru -S --needed --noconfirm lib32-mesa lib32-vulkan-radeon lib32-libva-mesa-driver lib32-mesa-vdpau

# old_amd
#paru -S --needed --noconfirm xf86-video-ati mesa amdvlk libva-mesa-driver mesa-vdpau

# 32-bit old_amd [NEEDS MULTILIB REPO ENABLED]
#paru -S --needed --noconfirm lib32-mesa lib32-amdvlk lib32-libva-mesa-driver lib32-mesa-vdpau

# amd microcode [IMPORTANT]
#paru -S --needed --noconfirm amd-ucode

# 32-bit modern_nvidia open-source [NEEDS MULTILIB REPO ENABLED]
#paru -S --needed --noconfirm lib32-nvidia-utils

# modern_nvidia proprietary [NEEDS ARCH REPO ENABLED]
#paru -S --needed --noconfirm nvidia nvidia-dkms nvidia-utils libva-nvidia-driver

# 32-bit modern_nvidia proprietary [NEEDS MULTILIB REPO ENABLED]
#paru -S --needed --noconfirm lib32-nvidia-utils

# old_nvidia nouveau
#paru -S --needed --noconfirm xf86-video-nouveau mesa mesa-vdpau libva-mesa-driver vulkan-nouveau

# 32-bit old_nvidia nouveau [NEEDS MULTILIB REPO ENABLED]
#paru -S --needed --nouveau lib32-mesa lib32-mesa-vdpau lib32-libva-mesa-driver lib32-vulkan-nouveau

###### DRIVERS ######


###### OPTIONAL ######

# ttf-ms-fonts [LEGACY]
#paru -S --needed --noconfirm ttf-ms-fonts

# enable backlight service for saving previous brightness you've set after rebooting your pc
#paru -S --needed --noconfirm backlight-runit && sudo ln -s /etc/runit/sv/backlight/ /run/runit/service

# thermald (supports tlp) [INTEL ONLY]
#paru -S --needed --noconfirm thermald-runit && sudo ln -s /etc/runit/sv/thermald/ /run/runit/service

# tlp
#paru -S --needed --noconfirm tlp-runit && sudo ln -s /etc/runit/sv/tlp/ /run/runit/service

# bluetooth
#paru -S --needed --noconfirm bluez-runit bluez-utils && sudo ln -s /etc/runit/sv/bluetoothd/ /run/runit/service

# bsp-layout (MASTER STACK)
#paru -S --needed --noconfirm bsp-layout

###### OPTIONAL ######


###### WINDOW MANAGERS ######

# bspwm (X11)
#paru -S --needed --noconfirm sxhkd bspwm polybar i3lock-color xorg-xinit xcolor xss-lock xorg-xset xsel xclip xdotool scrot rofi rxvt-unicode

# river (Wayland)
#paru -S --needed --noconfirm river waybar swaylock xorg-xwayland xdg-desktop-portal-wlr xdg-desktop-portal-gtk wl-clipboard wtype wlr-randr grim slurp tofi foot swayidle wlopm

###### WINDOW MANAGERS ######


# install your programs here
paru -S --needed --noconfirm nwg-look noto-fonts noto-fonts-emoji noto-fonts-cjk htop fastfetch neovim zathura zathura-pdf-poppler mpv ranger pcmanfm xarchiver ufw pavucontrol dunst libnotify brightnessctl nsxiv acpi ueberzug ffmpegthumbnailer

# enable ufw with recommended settings by chris_titus
sudo ufw limit 22/tcp && sudo ufw allow 80/tcp && sudo ufw allow 443/tcp && sudo ufw default deny incoming && sudo ufw default allow outgoing && sudo ufw enable

# sudo alternative (doas) [RECOMMENDED]
sudo rm -f /etc/doas.conf && echo "permit persist :wheel" | sudo tee -a /etc/doas.conf > /dev/null

# remove any orphaned packages
paru -Rnsudd --noconfirm && paru -Sc --noconfirm
