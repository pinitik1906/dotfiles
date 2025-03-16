#!/bin/bash

echo ""
echo ""
echo ""
echo "- PLEASE INSTALL opendoas BEFORE USING THIS SCRIPT AND TYPE INSIDE /etc/doas.conf WITH permit persist yourusername"
echo "- DO NOT LEAVE your computer unattended, it will ask for your password multiple times"
echo "- You might also check inside this script if you want to make changes."
echo ""
echo "This script will automatically reboot to apply all configurations"
echo ""
echo "If you want to cancel this install script, simultaneuously press CTRL and C"
echo ""


# add important groups
doas groupadd plugdev && doas groupadd cdrom && doas groupadd libvirt && doas usermod -aG video,audio,wheel,network,storage,kvm,plugdev,floppy,cdrom,optical,libvirt $USER

# checking updates & syncing repos
doas pacman -Syu --needed --noconfirm

# create folders for screenshooting, music player, and gnupg, otherwise it won't work
mkdir -p $HOME/stuffs/pic/screenshots && mkdir -p $HOME/.local/share/playlists && mkdir -p $HOME/.local/share/lyrics && mkdir -p $HOME/.local/share/gnupg

# copying all conf to home folder
mkdir -p $HOME/.config && cp -r $HOME/stuffs/git/dotfiles/artix/.config/* $HOME/.config/ && mkdir -p $HOME/.local/share/applications && cp -r $HOME/stuffs/git/dotfiles/artix/.local/share/applications/* $HOME/.local/share/applications/ && mkdir -p $HOME/.local/bin && cp -r $HOME/stuffs/git/dotfiles/artix/.local/bin/* $HOME/.local/bin/ && cp $HOME/stuffs/git/dotfiles/artix/.zprofile $HOME/.zprofile

# xdg-user-dirs
mkdir -p $HOME/stuffs/dls && mkdir -p $HOME/stuffs/doc && mkdir -p $HOME/stuffs/mus && mkdir -p $HOME/stuffs/vid

# copying my pre-configured grub
doas cp $HOME/stuffs/git/dotfiles/artix/things/grub /etc/default/grub

# applying grub configurations
doas mkinitcpio -P && doas grub-mkconfig -o /boot/grub/grub.cfg

# copying all xorg conf to /etc/X11/xorg.conf.d/
doas mkdir -p /etc/X11/xorg.conf.d && doas cp $HOME/stuffs/git/dotfiles/artix/things/40-libinput.conf /etc/X11/xorg.conf.d/ && doas cp $HOME/stuffs/git/dotfiles/artix/things/90-touchpad.conf /etc/X11/xorg.conf.d/

# copying preconfigured pacman.conf and paru.conf
doas pacman -S --needed --noconfirm artix-archlinux-support && doas cp -r $HOME/stuffs/git/dotfiles/artix/things/repo/pacman.conf /etc/pacman.conf && doas cp -r $HOME/stuffs/git/dotfiles/artix/things/repo/paru.conf /etc/paru.conf

# installing paru as a default AUR HELPER
doas pacman -Rnsdd --noconfirm sudo && doas pacman -S --needed --noconfirm base-devel git && git clone --depth 1 https://aur.archlinux.org/paru-bin.git $HOME/stuffs/git/paru-bin && cd $HOME/stuffs/git/paru-bin && makepkg -Csic --needed --noconfirm

# installing important dependencies
paru -S --needed --noconfirm dash iptables-runit base-devel elogind-runit polkit dbus-runit xorg-xhost libinih linux-firmware pipewire pipewire-pulse pipewire-alsa pipewire-jack mate-polkit ffmpeg less mandoc dunst libnotify zsh zsh-syntax-highlighting rsync-runit ufw-runit backlight-runit dragon-drop bat odt2txt poppler exiftool atool tar unzip unrar 7zip zstd

# enabling services
doas ln -s /etc/runit/sv/backlight/ /run/runit/service && doas ln -s /etc/runit/sv/rsyncd/ /run/runit/service

# enabling ufw with recommended settings by chris_titus
doas ln -s /etc/runit/sv/ufw/ /run/runit/service && doas ufw limit 22/tcp && doas ufw allow 80/tcp && doas ufw allow 443/tcp && doas ufw default deny incoming && doas ufw default allow outgoing && doas ufw enable

# enabling dbus for elogind and others
doas ln -s /etc/runit/sv/dbus/ /run/runit/service

# removing acpid and its service as it conflicts elogind
paru -Rnsdd --noconfirm acpid acpid-runit && doas rm -rf /etc/runit/sv/acpid && doas rm -rf /run/runit/service/acpid

# installing additional vulkan dependencies
paru -S --needed --noconfirm vulkan-icd-loader vulkan-swrast vulkan-mesa-layers

# 32bit vulkan dependencies [NEEDS MULTILIB REPO ENABLED]
#paru -S --needed --noconfirm lib32-vulkan-icd-loader lib32-vulkan-swrast lib32-vulkan-mesa-layers

# getting all of the git packages
git clone --depth 1 https://github.com/pinitik1906/st $HOME/stuffs/git/st && git clone --depth 1 https://github.com/pinitik1906/dwl $HOME/stuffs/git/dwl && git clone --depth 1 https://github.com/pinitik1906/dwm $HOME/stuffs/git/dwm && git clone --depth 1 https://github.com/pinitik1906/dmenu $HOME/stuffs/git/dmenu && git clone --depth 1 https://github.com/pinitik1906/slstatus $HOME/stuffs/git/slstatus

###### DRIVERS ######

# modern_intel [NEEDS ARCH REPO ENABLED]
#paru -S --needed --noconfirm mesa vulkan-intel libvdpau libvdpau-va-gl intel-media-driver xf86-video-intel && doas cp $HOME/stuffs/git/dotfiles/artix/things/20-intel.conf /etc/X11/xorg.conf.d/

# 32-bit modern_intel [NEEDS MULTILIB REPO ENABLED]
#paru -S --needed --noconfirm lib32-mesa lib32-vulkan-intel lib32-libvdpau lib32-libvdpau-va-gl

# old_intel [NEEDS ARCH REPO ENABLED]
#paru -S --needed --noconfirm mesa vulkan-intel libvdpau libvdpau-va-gl libva-intel-driver xf86-video-intel && doas cp $HOME/stuffs/git/dotfiles/artix/things/20-intel.conf /etc/X11/xorg.conf.d/

# 32-bit old_intel [NEEDS MULTILIB REPO ENABLED]
#paru -S --needed --noconfirm lib32-mesa lib32-vulkan-intel lib32-libvdpau lib32-libvdpau-va-gl lib32-libva-intel-driver

# intel microcode [IMPORTANT]
#paru -S --needed --noconfirm intel-ucode

# modern_amd
#paru -S --needed --noconfirm mesa vulkan-radeon xf86-video-amdgpu && doas cp $HOME/stuffs/git/dotfiles/artix/things/20-amdgpu.conf /etc/X11/xorg.conf.d/

# 32-bit modern_amd [NEEDS MULTILIB  ENABLED]
#paru -S --needed --noconfirm lib32-mesa lib32-vulkan-radeon

# old_amd
#paru -S --needed --noconfirm mesa amdvlk xf86-video-ati && doas cp $HOME/stuffs/git/dotfiles/artix/things/20-radeon.conf /etc/X11/xorg.conf.d/

# 32-bit old_amd [NEEDS MULTILIB REPO ENABLED]
#paru -S --needed --noconfirm lib32-mesa lib32-amdvlk

# amd microcode [IMPORTANT]
#paru -S --needed --noconfirm amd-ucode

# modern_nvidia open-source [NEEDS MULTILIB REPO ENABLED]
#paru -S --needed --noconfirm mesa nvidia-open nvidia-open-dkms nvidia-utils libva-nvidia-driver

# 32-bit modern_nvidia open-source [NEEDS MULTILIB REPO ENABLED]
#paru -S --needed --noconfirm lib32-mesa lib32-nvidia-utils

# modern_nvidia proprietary [NEEDS ARCH REPO ENABLED]
#paru -S --needed --noconfirm mesa nvidia nvidia-dkms nvidia-utils libva-nvidia-driver

# 32-bit modern_nvidia proprietary [NEEDS MULTILIB REPO ENABLED]
#paru -S --needed --noconfirm lib32-mesa lib32-lib32-nvidia-utils

# old_nvidia nouveau
#paru -S --needed --noconfirm mesa vulkan-nouveau xf86-video-nouveau

# 32-bit old_nvidia nouveau [NEEDS MULTILIB REPO ENABLED]
#paru -S --needed --noconfirm lib32-mesa lib32-vulkan-nouveau

###### DRIVERS ######


###### OPTIONAL ######

# librewolf (recommended)
paru -S --needed --noconfirm librewolf

# flatpak
#paru -S --needed --noconfirm flatpak

# virtualbox [VIRTUAL MACHINE]
#paru -S --needed --noconfirm virtualbox virtualbox-guest-utils

# qemu/virt-manager (recommended) [VIRTUAL MACHINE]
#paru -S --needed --noconfirm qemu-full virt-manager virt-viewer dnsmasq-runit vde2 bridge-utils openbsd-netcat libvirt-runit libguestfs && doas ln -s /etc/runit/sv/libvirtd/ /run/runit/service && doas ln -s /etc/runit/sv/virtlockd/ /run/runit/service && doas ln -s /etc/runit/sv/virtlogd/ /run/runit/service

# ttf-ms-fonts [LEGACY]
#paru -S --needed --noconfirm ttf-ms-fonts

# ueberzugpp
#paru -S --needed --noconfirm ueberzugpp ffmpegthumbnailer

# thinkfan [THINKPADS ONLY]
#doas cp -r $HOME/stuffs/git/dotfiles/artix/services/thinkfan/ /etc/sv/ && paru -S --needed --noconfirm thinkfan && doas cp $HOME/stuffs/git/dotfiles/artix/things/thinkfan.yaml /etc/ && doas ln -s /etc/runit/sv/thinkfan/ /run/runit/service

# tlp
#paru -S --needed --noconfirm tlp-runit && doas ln -s /etc/runit/sv/tlp/ /run/runit/service

# thermald [INTEL ONLY]
#paru -S --needed --noconfirm thermald-runit && doas ln -s /etc/runit/sv/thermald/ /run/runit/service

# intel-undervolt [INTEL ONLY]
#paru -S --needed --noconfirm intel-undervolt-runit && doas cp $HOME/stuffs/git/dotfiles/artix/things/intel-undervolt.conf /etc/intel-undervolt.conf && doas ln -s /etc/runit/sv/intel-undervolt/ /run/runit/service

# bluetooth
#paru -S --needed --noconfirm bluez-runit bluez-utils && doas ln -s /etc/runit/sv/bluetoothd/ /run/runit/service

###### OPTIONAL ######


###### WINDOW MANAGERS ######

# dwm (X11)
paru -S --needed --noconfirm xbacklight i3lock-color xwallpaper xorg-server xf86-input-libinput xorg-xauth xorg-xinit xss-lock xorg-xset xsel xclip xdotool xorg-xrandr scrot xcolor libx11 libxft libxinerama fontconfig freetype2 && cd $HOME/stuffs/git/st && doas make clean install && cd $HOME/stuffs/git/dmenu && doas make clean install && cd $HOME/stuffs/git/dwm && doas make clean install && cd $HOME/stuffs/git/slstatus && doas make clean install

# dwl (Wayland)
#paru -S --needed --noconfirm wmenu foot brightnessctl swaylock swaybg xdg-desktop-portal-wlr xdg-desktop-portal-gtk wl-clipboard wtype wlr-randr grim slurp swayidle wlopm qt5-wayland qt6-wayland wl-color-picker xf86-input-libinput libinput wayland wayland-protocols wlroots libxkbcommon pkgconf libxcb xorg-xwayland fcft libx11 libxft libxinerama && cd $HOME/stuffs/git/dwl && doas make clean install && cd $HOME/stuffs/git/slstatus && doas make clean install

###### WINDOW MANAGERS ######


# install your programs here
paru -S --needed --noconfirm noto-fonts noto-fonts-emoji noto-fonts-cjk htop fastfetch neovim zathura zathura-pdf-poppler mpv lf pavucontrol imv gammastep yt-dlp mpd mpc ncmpcpp newsboat

# fixing mandoc (temporary)
doas makewhatis -a

# replace bash with zsh
doas chsh -s /bin/zsh
chsh -s /bin/zsh

# make dash as the default in /bin/sh
doas ln -sf dash /bin/sh

# removing any orphaned git and packages
rm -rf $HOME/.bash_logout && rm -rf $HOME/.bash_history && rm -rf $HOME/.inputrc && rm -rf $HOME/stuffs/git/paru-bin && rm -rf $HOME/stuffs/git/st && rm -rf $HOME/stuffs/git/dmenu && rm -rf $HOME/stuffs/git/dwl && rm -rf $HOME/stuffs/git/dwm && rm -rf $HOME/stuffs/git/slstatus && paru -Qqtd | paru -Rnsdd --noconfirm - && paru -Sc --noconfirm && doas rm -rf $HOME/.cache

# trimming SSD if available
doas fstrim -av

# rebooting your pc
doas reboot
