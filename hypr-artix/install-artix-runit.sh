#!/bin/bash

# add important groups
sudo usermod -aG video $(whoami) && sudo usermod -aG audio $(whoami) && sudo usermod -aG wheel $(whoami)

# checking updates
sudo pacman -Syu --needed --noconfirm

# installing yay as a default AUR HELPER
sudo pacman -Syu --needed --noconfirm base-devel git && git clone --depth 1 https://aur.archlinux.org/yay-bin.git ~/stuffs/git/yay-bin && cd ~/stuffs/git/yay-bin && makepkg -si

# installing important dependencies
yay -Syu --needed --noconfirm elogind-runit polkit dbus xdg-desktop-portal-gtk

# removing acpid and its service as it conflicts elogind
yay -Rnsudd --noconfirm acpid acpid-runit && sudo rm -rf /etc/runit/sv/acpid

# clone madand's runit-services (you have an option to enable this for the optimization and optional sections)
# git clone --depth 1 https://github.com/madand/runit-services.git ~/stuffs/git/runit-services


###### DRIVERS ######

# install intel drivers
# yay -Syu --needed --noconfirm xf86-video-intel mesa lib32-mesa vulkan-intel lib32-vulkan-intel intel-media-driver libva-intel-driver

# install intel microcode (IMPORTANT)
# yay -Syu --needed --noconfirm intel-ucode

# install modern_amd drivers
# yay -Syu --needed --noconfirm xf86-video-amdgpu mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau

# install old_amd drivers 
# yay -Syu --needed --noconfirm xf86-video-ati mesa lib32-mesa amdvlk lib32-amdvlk libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau

# install amd microcode (IMPORTANT)
# yay -Syu --needed --noconfirm amd-ucode

# install modern_nvidia open-source drivers
# yay -Syu --needed --noconfirm nvidia-open nvidia-open-dkms nvidia-utils lib32-nvidia-utils

# install modern_nvidia proprietary drivers
# yay -Syu --needed --noconfirm nvidia nvidia-dkms nvidia-utils lib32-nvidia-utils

# install bumblebee (ONLY FOR MODERN NVIDIA DRIVERS AND NVIDIA OPTIMUS SUPPORT)
# yay -Syu --needed --noconfirm bumblebee-runit bbswitch && sudo groupadd bumblebee && sudo gpasswd -a $(whoami) bumblebee && sudo ln -s /etc/runit/sv/bumblebeed /run/runit/service

# install old_nvidia nouveau drivers
# yay -Syu --needed --noconfirm xf86-video-nouveau mesa lib32-mesa vulkan-nouveau lib32-vulkan-nouveau

###### DRIVERS ######


###### OPTIMIZATION ######

# install profile-sync-daemon (recommended)
# yay -Syu --needed --noconfirm profile-sync-daemon && sudo cp -r ~/stuffs/git/runit-services/psd /etc/runit/sv/ && sudo ln -s /etc/runit/sv/psd/ /run/runit/service

# install ananicy-cpp
# yay -Syu --needed --noconfirm ananicy-cpp-runit && sudo ln -s /etc/runit/sv/ananicy-cpp/ /run/runit/service

# install zram
# yay -Syu --needed --noconfirm zramen-runit && sudo ln -s /etc/runit/sv/zramen/ /run/runit/service

# install preload (HDDs ONLY)
# yay -Syu --needed --noconfirm preload && echo "preload" | sudo tee -a /etc/rc.local > /dev/null

###### OPTIMIZATION ######


###### OPTIONAL ######

# install ttf-ms-fonts (LEGACY)
# yay -Syu --needed --noconfirm ttf-ms-fonts

# enable backlight for saving previous brightness you've set after rebooting your pc
# yay -Syu --needed --noconfirm backlight-runit && sudo ln -s /etc/runit/sv/backlight/ /run/runit/service

# install and enable thinkfan (THINKPADS ONLY)
# sudo cp -r ~/stuffs/git/runit-services/thinkfan /etc/runit/sv/ && yay -Syu --needed --noconfirm thinkfan && sudo ln -s /etc/runit/sv/thinkfan/ /run/runit/service

# install and enable thermald (also supports tlp)
# yay -Syu --needed --noconfirm thermald-runit 

# install and enable tlp
# yay -Syu --needed --noconfirm tlp-runit && sudo ln -s /etc/runit/sv/tlp/ /run/runit/service

# install and enable bluetooth
# yay -Syu --needed --noconfirm bluez-runit bluez-utils && sudo ln -s /etc/runit/sv/bluetoothd/ /run/runit/service

###### OPTIONAL ######


# install hyprland
yay -Syu --needed --noconfirm hyprland waybar hyprpicker hyprshot hyprlock xdg-desktop-portal-hyprland wl-clipboard wlsunset foot ueberzugpp ffmpegthumbnailer

# install your programs here
yay -Syu --needed --noconfirm xorg linux-firmware noto-fonts noto-fonts-cjk noto-fonts-emoji dunst libnotify rofi rofi-calc rofi-emoji brightnessctl mpv nsxiv ranger zathura zathura-pdf-poppler pipewire pipewire-alsa pipewire-pulse pipewire-jack pavucontrol ufw acpi lxsession

# enable ufw with recommended settings by chris_titus
sudo ufw limit 22/tcp && sudo ufw allow 80/tcp && sudo ufw allow 443/tcp && sudo ufw default deny incoming && sudo ufw default allow outgoing && sudo ufw enable
