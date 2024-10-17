#!/bin/bash

# add important groups
sudo usermod -aG video $(whoami) && sudo usermod -aG audio $(whoami) && sudo usermod -aG wheel $(whoami)

# remove irqbalance as it reduces performance
sudo pacman -Rnsudd irqbalance

# checking updates
sudo pacman -Syu --needed --noconfirm

# installing paru as a default AUR HELPER
sudo pacman -Syu --needed --noconfirm base-devel git && git clone --depth 1 https://aur.archlinux.org/paru-bin.git ~/stuffs/git/paru-bin && cd ~/stuffs/git/paru-bin && makepkg -si && echo "[bin]" | sudo tee -a ~/.config/paru/paru.conf > /dev/null

# installing important dependencies
paru -Syu --needed --noconfirm elogind-runit polkit dbus xdg-desktop-portal-gtk

# removing acpid and its service as it conflicts elogind
paru -Rnsudd --noconfirm acpid acpid-runit && sudo rm -rf /etc/runit/sv/acpid

# clone madand's runit-services (you have an option to enable this for the optimization and optional sections)
# git clone --depth 1 https://github.com/madand/runit-services.git ~/stuffs/git/runit-services


###### DRIVERS ######

# install intel drivers (NEEDS MULTILIB AND ARCH REPO ENABLED)
# paru -Syu --needed --noconfirm xf86-video-intel mesa lib32-mesa vulkan-intel lib32-vulkan-intel intel-media-driver libva-intel-driver lib32-libva-intel-driver libvdpau lib32-libvdpau libvdpau-va-gl lib32-libvdpau-va-gl intel-media-sdk

# install intel microcode [IMPORTANT]
# paru -Syu --needed --noconfirm intel-ucode

# install modern_amd drivers (NEEDS MULTILIB REPO ENABLED)
# paru -Syu --needed --noconfirm xf86-video-amdgpu mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau

# install old_amd drivers (NEEDS MULTILIB REPO ENABLED)
# paru -Syu --needed --noconfirm xf86-video-ati mesa lib32-mesa amdvlk lib32-amdvlk libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau

# install amd microcode [IMPORTANT]
# paru -Syu --needed --noconfirm amd-ucode

# install modern_nvidia open-source drivers (NEEDS MULTILIB REPO ENABLED)
# paru -Syu --needed --noconfirm nvidia-open nvidia-open-dkms nvidia-utils lib32-nvidia-utils

# install modern_nvidia proprietary drivers (NEEDS MULTILIB REPO ENABLED)
# paru -Syu --needed --noconfirm nvidia nvidia-dkms nvidia-utils lib32-nvidia-utils

# install bumblebee (ONLY FOR MODERN NVIDIA DRIVERS AND NVIDIA OPTIMUS SUPPORT)
# paru -Syu --needed --noconfirm bumblebee-runit bbswitch && sudo groupadd bumblebee && sudo gpasswd -a $(whoami) bumblebee && sudo ln -s /etc/runit/sv/bumblebeed /run/runit/service

# install old_nvidia nouveau drivers (NEEDS MULTILIB REPO ENABLED)
# paru -Syu --needed --noconfirm xf86-video-nouveau mesa lib32-mesa vulkan-nouveau lib32-vulkan-nouveau

###### DRIVERS ######


###### OPTIMIZATION ######

# install profile-sync-daemon [RECOMMENDED]
paru -Syu --needed --noconfirm profile-sync-daemon && sudo cp -r ~/stuffs/git/runit-services/psd /etc/runit/sv/ && sudo ln -s /etc/runit/sv/psd/ /run/runit/service

# install ananicy-cpp [RECOMMENDED]
paru -Syu --needed --noconfirm ananicy-cpp-runit && sudo ln -s /etc/runit/sv/ananicy-cpp/ /run/runit/service && sudo rm -rf /etc/ananicy.d/ && sudo git clone --depth 1 https://github.com/CachyOS/ananicy-rules.git /etc/ananicy.d && echo "[safe]" | tee -a ~/.gitconfig > /dev/null && echo "  directory = /etc/ananicy.d/" | tee -a ~/.gitconfig > /dev/null

# install zram
# paru -Syu --needed --noconfirm zramen-runit && sudo ln -s /etc/runit/sv/zramen/ /run/runit/service

# install preload [HDDs ONLY]
# paru -Syu --needed --noconfirm preload && echo "preload" | sudo tee -a /etc/rc.local > /dev/null

###### OPTIMIZATION ######


###### OPTIONAL ######

# install ttf-ms-fonts [LEGACY]
# paru -Syu --needed --noconfirm ttf-ms-fonts

# install earlyoom [RECOMMENDED]
paru -Syu --needed --noconfirm earlyoom-runit && sudo ln -s /etc/runit/sv/earlyoom/ /run/runit/service

# enable backlight for saving previous brightness you've set after rebooting your pc
# paru -Syu --needed --noconfirm backlight-runit && sudo ln -s /etc/runit/sv/backlight/ /run/runit/service

# install and enable thinkfan [THINKPADS ONLY]
# sudo cp -r ~/stuffs/git/runit-services/thinkfan /etc/runit/sv/ && paru -Syu --needed --noconfirm thinkfan && sudo ln -s /etc/runit/sv/thinkfan/ /run/runit/service

# install and enable thermald (supports tlp) [INTEL ONLY]
# paru -Syu --needed --noconfirm thermald-runit 

# install and enable tlp
# paru -Syu --needed --noconfirm tlp-runit && sudo ln -s /etc/runit/sv/tlp/ /run/runit/service

# install and enable bluetooth
# paru -Syu --needed --noconfirm bluez-runit bluez-utils && sudo ln -s /etc/runit/sv/bluetoothd/ /run/runit/service

###### OPTIONAL ######


###### WINDOW MANAGERS ######

# install bspwm (X11)
# paru -Syu --needed --noconfirm bspwm sxhkd polybar alacritty i3lock xorg-xinit xcolor xss-lock xsel xclip xdotool redshift scrot

# install hyprland (Wayland)
# paru -Syu --needed --noconfirm hyprland waybar hyprpicker hyprshot hyprlock xdg-desktop-portal-hyprland wl-clipboard wlsunset alacritty ueberzugpp ffmpegthumbnailer

###### WINDOW MANAGERS ######


# install your programs here
paru -Syu --needed --noconfirm xorg linux-firmware opendoas noto-fonts noto-fonts-cjk noto-fonts-emoji dunst libnotify rofi rofi-calc rofi-emoji brightnessctl mpv nsxiv ranger zathura zathura-pdf-poppler pipewire pipewire-alsa pipewire-pulse pipewire-jack pavucontrol ufw acpi lxsession

# enable ufw with recommended settings by chris_titus
sudo ufw limit 22/tcp && sudo ufw allow 80/tcp && sudo ufw allow 443/tcp && sudo ufw default deny incoming && sudo ufw default allow outgoing && sudo ufw enable

# sudo alternative (opendoas/doas), simple yet secure and minimal (recommended)
sudo rm -f /etc/doas.conf && echo "permit persist :wheel" | sudo tee -a /etc/doas.conf > /dev/null

# remove any orphaned packages
paru -Rnsudd --noconfirm && paru -Sc --noconfirm

# removing sudo
paru -Rnsudd --noconfirm sudo
