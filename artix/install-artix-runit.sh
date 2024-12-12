#!/bin/sh

# add important groups
sudo usermod -aG video,audio,wheel,network $(whoami)

# create folder for screenshotting, otherwise it won't work
mkdir -p $HOME/stuffs/pic/screenshots

# copying all conf to home folder
cp $HOME/stuffs/git/dotfiles/artix/.config/* $HOME/.config/ && cp $HOME/stuffs/git/dotfiles/artix/.bash_profile $HOME/.bash_profile && cp $HOME/stuffs/git/dotfiles/artix/.bashrc $HOME/.bashrc && cp $HOME/stuffs/git/dotfiles/artix/.xinitrc $HOME/.xinitrc && cp $HOME/stuffs/git/dotfiles/artix/.Xresources $HOME/.Xresources

# copying all xorg conf to /etc/X11/xorg.conf.d/
sudo mkdir -p /etc/X11/xorg.conf.d && sudo cp $HOME/stuffs/git/dotfiles/artix/20-intel.conf /etc/X11/xorg.conf.d/ && sudo cp $HOME/stuffs/git/dotfiles/artix/40-libinput.conf /etc/X11/xorg.conf.d/ && sudo cp $HOME/stuffs/git/dotfiles/artix/90-touchpad.conf /etc/X11/xorg.conf.d/

# copying preconfigured pacman.conf and paru.conf
doas pacman -S --needed --noconfirm artix-archlinux-support && doas cp -r $HOME/stuffs/git/dotfiles/artix/pacman.conf /etc/pacman.conf && doas cp -r $HOME/stuffs/git/dotfiles/artix/paru.conf /etc/paru.conf

# checking updates, syncing repos
sudo pacman -Syu --needed --noconfirm

# installing opendoas & removing sudo
sudo rm -f /etc/doas.conf && echo "permit persist :wheel" | sudo tee -a /etc/doas.conf > /dev/null && sudo pacman -S --needed --noconfirm opendoas && doas pacman -Rnsdd --noconfirm sudo

# installing paru as a default AUR HELPER
doas pacman -S --needed --noconfirm base-devel git && git clone --depth 1 https://aur.archlinux.org/paru-bin.git $HOME/stuffs/git/paru-bin && cd $HOME/stuffs/git/paru-bin && makepkg -si 

# installing important dependencies
paru -Rnsdd --noconfirm jack2
paru -S --needed --noconfirm base-devel elogind-runit polkit dbus xorg linux-firmware pipewire pipewire-alsa pipewire-pulse pipewire-jack mate-polkit ffmpeg playerctl less mandoc ttf-inconsolata

# removing acpid and its service as it conflicts elogind
paru -Rnsdd --noconfirm acpid acpid-runit && doas rm -rf /etc/runit/sv/acpid

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
#paru -S --needed --noconfirm backlight-runit && doas ln -s /etc/runit/sv/backlight/ /run/runit/service

# thinkfan (please enable thinkfan service after you reboot your pc) [THINKPADS ONLY]
#paru -S --needed --noconfirm thinkfan-runit && doas cp $HOME/stuffs/git/dotfiles/artix/thinkfan.yaml /etc/

# thermald (supports tlp) [INTEL ONLY]
#paru -S --needed --noconfirm thermald-runit && doas ln -s /etc/runit/sv/thermald/ /run/runit/service

# tlp
#paru -S --needed --noconfirm tlp-runit && doas ln -s /etc/runit/sv/tlp/ /run/runit/service

# bluetooth
#paru -S --needed --noconfirm bluez-runit bluez-utils && doas ln -s /etc/runit/sv/bluetoothd/ /run/runit/service

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
paru -S --needed --noconfirm nwg-look noto-fonts noto-fonts-emoji noto-fonts-cjk htop fastfetch neovim zathura zathura-pdf-poppler mpv ranger pcmanfm xarchiver ufw pavucontrol dunst libnotify brightnessctl nsxiv acpi ueberzugpp ffmpegthumbnailer

# enable ufw with recommended settings by chris_titus
doas ufw limit 22/tcp && doas ufw allow 80/tcp && doas ufw allow 443/tcp && doas ufw default deny incoming && doas ufw default allow outgoing && doas ufw enable

# remove any orphaned packages
paru -Rnsudd --noconfirm && paru -Sc --noconfirm

# rebooting your pc
loginctl reboot
