#!/bin/sh

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
doas groupadd plugdev
doas groupadd cdrom

doas usermod -aG video,audio,wheel,network,storage,kvm,plugdev,floppy,cdrom,optical $USER

# checking updates & syncing repos
doas pacman -Syu --needed --noconfirm

# create folder for screenshooting, otherwise it won't work
mkdir -p $HOME/stuffs/pic/screenshots

# copying all conf to home folder
rm -rf $HOME/.config
rm -rf $HOME/.local
mkdir -p $HOME/.config
cp -r $HOME/stuffs/git/dotfiles/artix/.config $HOME
cp -r $HOME/stuffs/git/dotfiles/artix/.local $HOME

cp $HOME/stuffs/git/dotfiles/artix/.bash_profile $HOME/.bash_profile
cp $HOME/stuffs/git/dotfiles/artix/.Xresources $HOME/.Xresources
cp $HOME/stuffs/git/dotfiles/artix/.xinitrc $HOME/.xinitrc
cp $HOME/stuffs/git/dotfiles/artix/.bashrc $HOME/.bashrc

# copying all xorg conf to /etc/X11/xorg.conf.d/
doas mkdir -p /etc/X11/xorg.conf.d
doas cp $HOME/stuffs/git/dotfiles/artix/40-libinput.conf /etc/X11/xorg.conf.d/
doas cp $HOME/stuffs/git/dotfiles/artix/90-touchpad.conf /etc/X11/xorg.conf.d/

# copying preconfigured pacman.conf and paru.conf
doas pacman -S --needed --noconfirm artix-archlinux-support && doas cp -r $HOME/stuffs/git/dotfiles/artix/pacman.conf /etc/pacman.conf && doas cp -r $HOME/stuffs/git/dotfiles/artix/paru.conf /etc/paru.conf

# installing paru as a default AUR HELPER
doas pacman -Rnsdd --noconfirm sudo && doas pacman -S --needed --noconfirm base-devel git && git clone --depth 1 https://aur.archlinux.org/paru-bin.git $HOME/stuffs/git/paru-bin && cd $HOME/stuffs/git/paru-bin && makepkg -Csic --needed --noconfirm

# installing important dependencies
paru -Rnsdd --noconfirm jack2
paru -S --needed --noconfirm base-devel elogind-runit polkit dbus xorg-xhost libinih linux-firmware pipewire pipewire-alsa pipewire-pulse pipewire-jack mate-polkit ffmpeg playerctl less mandoc dunst libnotify runit-bash-completions ufw-runit acpi backlight-runit && doas ln -s /etc/runit/sv/backlight/ /run/runit/service

# removing acpid and its service as it conflicts elogind
paru -Rnsdd --noconfirm acpid acpid-runit && doas rm -rf /etc/runit/sv/acpid

# installing additional vulkan dependencies
paru -S --needed --noconfirm vulkan-icd-loader vulkan-swrast vulkan-mesa-layers

# 32bit vulkan dependencies [NEEDS MULTILIB REPO ENABLED]
#paru -S --needed --noconfirm lib32-vulkan-icd-loader lib32-vulkan-swrast lib32-vulkan-mesa-layers

# clone madand's runit-services
git clone --depth 1 https://github.com/madand/runit-services.git $HOME/stuffs/git/runit-services


###### DRIVERS ######


# modern_intel [NEEDS ARCH REPO ENABLED]
#paru -S --needed --noconfirm mesa vulkan-intel libvdpau libvdpau-va-gl intel-media-driver xf86-video-intel

# 32-bit modern_intel [NEEDS MULTILIB REPO ENABLED]
#paru -S --needed --noconfirm lib32-mesa lib32-vulkan-intel lib32-libvdpau lib32-libvdpau-va-gl

# old_intel [NEEDS ARCH REPO ENABLED]
#paru -S --needed --noconfirm mesa vulkan-intel libvdpau libvdpau-va-gl libva-intel-driver-git xf86-video-intel

# 32-bit old_intel [NEEDS MULTILIB REPO ENABLED]
#paru -S --needed --noconfirm lib32-mesa lib32-vulkan-intel lib32-libvdpau lib32-libvdpau-va-gl lib32-libva-intel-driver

# intel microcode [IMPORTANT]
#paru -S --needed --noconfirm intel-ucode

# modern_amd
#paru -S --needed --noconfirm mesa vulkan-radeon xf86-video-amdgpu

# 32-bit modern_amd [NEEDS MULTILIB  ENABLED]
#paru -S --needed --noconfirm lib32-mesa lib32-vulkan-radeon

# old_amd
#paru -S --needed --noconfirm mesa amdvlk xf86-video-ati

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

# ttf-ms-fonts [LEGACY]
#paru -S --needed --noconfirm ttf-ms-fonts

# thinkfan (please enable thinkfan service after you reboot your pc) [THINKPADS ONLY]
#paru -S --needed --noconfirm thinkfan-runit && doas cp $HOME/stuffs/git/dotfiles/artix/thinkfan.yaml /etc/

# thermald (supports tlp) [INTEL ONLY]
#paru -S --needed --noconfirm thermald-runit && doas ln -s /etc/runit/sv/thermald/ /run/runit/service

# tlp
#paru -S --needed --noconfirm tlp-runit && doas ln -s /etc/runit/sv/tlp/ /run/runit/service

# bluetooth
#paru -S --needed --noconfirm bluez-runit bluez-utils && doas ln -s /etc/runit/sv/bluetoothd/ /run/runit/service

###### OPTIONAL ######


###### WINDOW MANAGERS ######

# bspwm (X11)
paru -S --needed --noconfirm sxhkd bspwm polybar i3lock-color xorg-server xf86-input-libinput xorg-xauth xorg-xinit xorg-xrdb xss-lock xorg-xset xsel xclip xdotool xorg-xrandr scrot rofi lxappearance xcolor rxvt-unicode-truecolor-wide-glyphs bsp-layout

# river (Wayland)
#paru -S --needed --noconfirm river waybar swaylock xorg-xwayland xdg-desktop-portal-wlr xdg-desktop-portal-gtk wl-clipboard wtype wlr-randr grim slurp tofi swayidle wlopm qt5-wayland qt6-wayland qt5ct qt6ct nwg-look foot wl-color-picker

###### WINDOW MANAGERS ######


# install your programs here
paru -S --needed --noconfirm noto-fonts noto-fonts-emoji noto-fonts-cjk htop fastfetch neovim zathura zathura-pdf-poppler mpv pcmanfm-gtk3 xarchiver pavucontrol brightnessctl imv-git gammastep

# enable ufw with recommended settings by chris_titus
doas ln -s /etc/runit/sv/ufw/ /run/runit/service && doas ufw limit 22/tcp && doas ufw allow 80/tcp && doas ufw allow 443/tcp && doas ufw default deny incoming && doas ufw default allow outgoing && doas ufw enable

# remove any orphaned packages
paru -Qqtd | paru -Rns --noconfirm - && paru -Sc --noconfirm

# rebooting your pc
doas reboot
