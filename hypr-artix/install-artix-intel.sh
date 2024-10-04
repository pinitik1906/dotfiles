#!/bin/bash

# checking updates
sudo pacman -Syyu --needed --noconfirm

# installing yay as a default AUR HELPER
sudo pacman -Syyu --needed --noconfirm base-devel git && git clone --depth 1 https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si


###### DRIVERS OPTION ######

# install intel drivers
yay -Syyu --needed --noconfirm xf86-video-intel mesa lib32-mesa vulkan-intel lib32-vulkan-intel intel-media-driver libva-intel-driver

# install modern_amd drivers
yay -Syyu --needed --noconfirm xf86-video-amdgpu mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau

# install old_amd drivers 
yay -Syyu --needed --noconfirm xf86-video-ati mesa lib32-mesa amdvlk lib32-amdvlk libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau

###### DRIVERS OPTION ######


###### OPTIONAL SECTIONS ######
###### OPTIONAL SECTIONS ######


# installing hyprland
yay -Syyu --needed --noconfirm hyprland hyprpicker hyprshot hyprlock 

# installing dependencies
yay -Syyu --needed --noconfirm xorg dunst mpv nsxiv ranger zathura zathura-pdf-poppler bluez bluez-runit bluez-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack pavucontrol libnotify ufw

# ufw recommended settings
sudo ufw limit 22/tcp && sudo ufw allow 80/tcp && sudo ufw allow 443/tcp && sudo ufw default deny incoming && sudo ufw default allow outgoing && sudo ufw enable
