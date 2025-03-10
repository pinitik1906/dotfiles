#!/bin/sh

echo ""
echo ""
echo ""
echo "- DO NOT LEAVE your computer unattended, it will ask for your password multiple times"
echo "- You might check inside this script if you want to make changes."
echo ""
echo "This script will automatically reboot to apply all configurations"
echo ""
echo "If you want to cancel this install script, simultaneuously press CTRL and C"
echo ""


###### REPO ######

# enable nonfree and multilib [GLIBC-x86_64]
#sudo cp $HOME/stuffs/git/dotfiles/void/things/repo/glibc-nonfree-32bit.conf /etc/xbps.d/00-repository-main.conf

# enable nonfree [MUSL-x86_64]
#sudo cp $HOME/stuffs/git/dotfiles/void/things/repo/musl-nonfree.conf /etc/xbps.d/00-repository-main.conf

###### REPO ######


# add important groups
sudo groupadd plugdev && sudo groupadd cdrom && sudo groupadd libvirt && sudo usermod -aG video,audio,wheel,network,storage,kvm,plugdev,floppy,cdrom,optical,libvirt $USER

# checking updates & syncing repos
sudo xbps-install -Suvy

# create folders for screenshooting, music player, and gnupg, otherwise it won't work
mkdir -p $HOME/stuffs/pic/screenshots && mkdir -p $HOME/.local/share/playlists && mkdir -p $HOME/.local/share/lyrics && mkdir -p $HOME/.local/share/gnupg

# copying all conf to home folder
mkdir $HOME/.config && cp -r $HOME/stuffs/git/dotfiles/void/.config/* $HOME/.config/ && mkdir -p $HOME/.local/share/applications && cp -r $HOME/stuffs/git/dotfiles/void/.local/share/applications/* $HOME/.local/share/applications/ && cp $HOME/stuffs/git/dotfiles/void/.bash_profile $HOME/.bash_profile && cp $HOME/stuffs/git/dotfiles/void/.bashrc $HOME/.bashrc

# xdg-user-dirs
mkdir -p $HOME/stuffs/dls && mkdir -p $HOME/stuffs/doc && mkdir -p $HOME/stuffs/mus && mkdir -p $HOME/stuffs/vid

# copying my pre-configured grub
sudo cp $HOME/stuffs/git/dotfiles/void/things/grub /etc/default/grub

# applying grub configurations
sudo dracut --force && sudo update-grub

# copying all xorg conf to /etc/X11/xorg.conf.d/
sudo mkdir -p /etc/X11/xorg.conf.d && sudo cp $HOME/stuffs/git/dotfiles/void/things/40-libinput.conf /etc/X11/xorg.conf.d/ && sudo cp $HOME/stuffs/git/dotfiles/void/things/90-touchpad.conf /etc/X11/xorg.conf.d/

# installing opendoas & removing sudo
sudo rm -f /etc/doas.conf && echo "permit persist :wheel" | sudo tee -a /etc/doas.conf > /dev/null && sudo xbps-install -vy opendoas && doas xbps-remove -RFfvy sudo

# installing important dependencies
doas xbps-install -vy xtools iptables base-devel elogind polkit dbus rtkit sof-firmware fmt bc xhost inih opendoas linux-firmware pipewire alsa-pipewire libjack-pipewire mate-polkit ffmpeg playerctl less mdocml dunst libnotify bash-completion rsync ufw acpi bat odt2txt poppler exiftool atool tar unzip unrar 7zip zstd fontconfig libX11 libXft harfbuzz

# enable alsa with pipewire
doas mkdir -p /etc/alsa/conf.d && doas ln -s /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d && doas ln -s /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d

# make jack works well
doas mkdir -p /etc/ld.so.conf.d && doas cp -r $HOME/stuffs/git/dotfiles/void/things/jack.conf /etc/ld.so.conf.d/pipewire-jack.conf && doas ldconfig

# enabling services
doas cp -r $HOME/stuffs/git/dotfiles/void/services/backlight /etc/sv/ && doas ln -s /etc/sv/rsyncd/ /var/service && doas ln -s /etc/sv/backlight/ /var/service

# enabling ufw with recommended settings by chris_titus
doas ln -s /etc/sv/ufw/ /var/service && doas ufw limit 22/tcp && doas ufw allow 80/tcp && doas ufw allow 443/tcp && doas ufw default deny incoming && doas ufw default allow outgoing && doas ufw enable

# enabling dbus for elogind and others
doas ln -s /etc/sv/dbus/ /var/service

# removing acpid and its service as it conflicts elogind
doas xbps-remove -RFfvy acpid && doas rm -rf /etc/sv/acpid && doas rm -rf /var/service/acpid

# installing additional vulkan dependencies
doas xbps-install -vy vulkan-loader mesa-vulkan-lavapipe

# 32-bit vulkan dependencies [NEEDS MULTILIB REPO ENABLED, GLIBC ONLY]
#doas xbps-install -vy vulkan-loader-32bit mesa-vulkan-lavapipe-32bit


###### DRIVERS ######

# modern_intel [NEEDS NONFREE REPO ENABLED]
#doas xbps-install -vy mesa-dri mesa-vulkan-intel libvdpau libvdpau-va-gl intel-media-driver xf86-video-intel linux-firmware-intel && doas cp $HOME/stuffs/git/dotfiles/void/things/20-intel.conf /etc/X11/xorg.conf.d/

# 32-bit modern_intel [NEEDS MULTILIB REPO ENABLED, GLIBC ONLY]
#doas xbps-install -vy mesa-dri-32bit mesa-vulkan-intel-32bit libvdpau-32bit libvdpau-va-gl-32bit

# old_intel [NEEDS NONFREE REPO ENABLED]
#doas xbps-install -vy mesa-dri mesa-vulkan-intel libvdpau libvdpau-va-gl libva-intel-driver xf86-video-intel linux-firmware-intel && doas cp $HOME/stuffs/git/dotfiles/void/things/20-intel.conf /etc/X11/xorg.conf.d/

# 32-bit old_intel [NEEDS MULTILIB REPO ENABLED, GLIBC ONLY]
#doas xbps-install -vy mesa-dri-32bit mesa-vulkan-intel-32bit libvdpau-32bit libvdpau-va-gl-32bit libva-intel-driver-32bit

# intel microcode (NEEDS NONFREE REPO ENABLED) [IMPORTANT]
#doas xbps-install -vy intel-ucode

# modern_amd [NEEDS NONFREE REPO ENABLED]
#doas xbps-install -vy mesa-dri mesa-vaapi mesa-vdpau mesa-vulkan-radeon xf86-video-amdgpu && doas cp $HOME/stuffs/git/dotfiles/void/things/20-amdgpu.conf /etc/X11/xorg.conf.d/

# 32-bit modern_amd [NEEDS MULTILIB REPO ENABLED, GLIBC ONLY]
#doas xbps-install -vy mesa-dri-32bit mesa-vaapi-32bit mesa-vdpau-32bit mesa-vulkan-radeon-32bit

# old_amd [NEEDS NONFREE REPO ENABLED]
#doas xbps-install -vy mesa-dri mesa-vaapi mesa-vdpau amdvlk xf86-video-ati && doas cp $HOME/stuffs/git/dotfiles/void/things/20-radeon.conf /etc/X11/xorg.conf.d/

# 32-bit old_amd [NEEDS MULTILIB REPO ENABLED, GLIBC ONLY]
#doas xbps-install -vy mesa-dri-32bit mesa-vaapi-32bit mesa-vdpau-32bit amdvlk-32bit

# amd microcode (NEEDS NONFREE REPO ENABLED) [IMPORTANT]
#doas xbps-install -vy linux-firmware-amd

# modern_nvidia proprietary [NEEDS NONFREE REPO ENABLED]
#doas xbps-install -vy mesa-dri mesa-vdpau nvidia-libs nvidia nvidia-dkms linux-firmware-nvidia nvidia-firmware nvidia-vaapi-driver

# 32-bit modern_nvidia proprietary [NEEDS MULTILIB REPO ENABLED, GLIBC ONLY]
#doas xbps-install -vy mesa-dri-32bit mesa-vdpau-32bit nvidia-libs-32bit

# old_nvidia nouveau [NEEDS NONFREE REPO ENABLED]
#doas xbps-install -vy mesa-dri mesa-vdpau xf86-video-nouveau

# 32-bit old_nvidia nouveau [NEEDS MULTILIB REPO ENABLED, GLIBC ONLY]
#doas xbps-install -vy mesa-dri-32bit mesa-vdpau-32bit

###### DRIVERS ######


###### XBPS-SRC ######

# enable nonfree and multilib [GLIBC-x86_64]
#git clone --depth 1 https://github.com/void-linux/void-packages.git $HOME/stuffs/git/xbps-src && cp $HOME/stuffs/git/dotfiles/void/things/repo/allow-restricted.conf $HOME/stuffs/git/xbps-src/etc/conf && cd $HOME/stuffs/git/xbps-src && cp $HOME/stuffs/git/dotfiles/void/things/repo/glibc-remote.conf $HOME/stuffs/git/xbps-src/etc/xbps.d/repos-remote.conf && cp $HOME/stuffs/git/dotfiles/void/things/repo/glibc-remote-multilib.conf $HOME/stuffs/git/xbps-src/etc/xbps.d/repos-remote-x86_64-multilib.conf && ./xbps-src binary-bootstrap && cp -r $HOME/stuffs/git/dotfiles/void/things/xbps-src/* $HOME/stuffs/git/xbps-src/srcpkgs/

# enable nonfree [MUSL-x86_64]
#git clone --depth 1 https://github.com/void-linux/void-packages.git $HOME/stuffs/git/xbps-src && cp $HOME/stuffs/git/dotfiles/void/things/repo/allow-restricted.conf $HOME/stuffs/git/xbps-src/etc/conf && cd $HOME/stuffs/git/xbps-src && cp $HOME/stuffs/git/dotfiles/void/things/repo/musl-remote.conf $HOME/stuffs/git/xbps-src/etc/xbps.d/repos-remote-musl.conf && ./xbps-src binary-bootstrap && cp -r $HOME/stuffs/git/dotfiles/void/things/xbps-src/* $HOME/stuffs/git/xbps-src/srcpkgs/

###### XBPS-SRC ######


###### OPTIONAL ######

# librewolf (recommended)
doas cp $HOME/stuffs/git/dotfiles/void/things/repo/librewolf.conf /etc/xbps.d/00-librewolf-void.conf && doas xbps-install -Suvy librewolf

# flatpak
#doas xbps-install -vy flatpak && flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# virtualbox [VIRTUAL MACHINE / GLIBC ONLY]
#doas xbps-install -vy virtualbox-ose virtualbox-ose-guest virtualbox-ose-guest-dkms

# qemu/virt-manager (recommended) [VIRTUAL MACHINE]
#doas xbps-install -vy qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat libvirt libguestfs && doas ln -s /etc/sv/libvirtd/ /var/service && doas ln -s /etc/sv/virtlockd/ /var/service && doas ln -s /etc/sv/virtlogd/ /var/service

# msttcorefonts [NEEDS XBPS-SRC ENABLED / LEGACY]
#cd $HOME/stuffs/git/xbps-src && ./xbps-src -f pkg msttcorefonts && doas xbps-install -vy --repository hostdir/binpkgs msttcorefonts

# ueberzugpp [NEEDS XBPS-SRC ENABLED]
#cd $HOME/stuffs/git/xbps-src && ./xbps-src -f pkg cli11 && doas xbps-install -vy --repository hostdir/binpkgs cli11 && ./xbps-src -f pkg ueberzugpp && doas xbps-install -vy --repository hostdir/binpkgs ueberzugpp && doas xbps-install -vy ffmpegthumbnailer

# thinkfan [THINKPADS ONLY]
#doas cp -r $HOME/stuffs/git/dotfiles/void/services/thinkfan /etc/sv/ && doas xbps-install -Suvy thinkfan && doas cp $HOME/stuffs/git/dotfiles/void/things/thinkfan.yaml /etc/ && doas ln -s /etc/sv/thinkfan/ /var/service

# tlp
#doas xbps-install -vy tlp && doas ln -s /etc/sv/tlp/ /var/service

# thermald [INTEL ONLY]
#doas xbps-install -vy thermald && doas ln -s /etc/sv/thermald/ /var/service

# intel-undervolt [INTEL ONLY]
#doas xbps-install -vy intel-undervolt && doas cp $HOME/stuffs/git/dotfiles/void/things/intel-undervolt.conf /etc/intel-undervolt.conf && doas cp -r $HOME/stuffs/git/dotfiles/void/services/intel-undervolt/ /etc/sv/ && doas ln -s /etc/sv/intel-undervolt/ /var/service

# bluetooth
#doas xbps-install -vy bluez bluez-alsa libspa-bluetooth && doas ln -s /etc/sv/bluetoothd/ /var/service

###### OPTIONAL ######


###### OPTIMIZATIONS ######

# earlyoom (recommended)
doas xbps-install -vy earlyoom && doas ln -s /etc/sv/earlyoom/ /var/service

# zram (recommended)
doas xbps-install -vy zramen && doas ln -s /etc/sv/zramen/ /var/service

# profile-sync-daemon (recommended)
git clone --depth 1 https://github.com/graysky2/profile-sync-daemon.git $HOME/stuffs/git/psd && cd $HOME/stuffs/git/psd/ && make && doas make install && doas rm -rf /usr/lib/systemd/ && doas cp -r $HOME/stuffs/git/dotfiles/void/things/psd/* /usr/share/psd/browsers/ && doas cp -r $HOME/stuffs/git/dotfiles/void/services/psd/ /etc/sv/ && doas ln -s /etc/sv/psd/ /var/service && psd && cp $HOME/stuffs/git/dotfiles/void/.config/psd/psd.conf $HOME/.config/psd/psd.conf && cd $HOME

# ananicy-cpp (recommended)
doas xbps-install -vy wget cmake fmt spdlog json-c++ && wget https://gitlab.com/ananicy-cpp/ananicy-cpp/-/archive/v1.1.1/ananicy-cpp-v1.1.1.tar.gz && tar -xvf ananicy-cpp-v1.1.1.tar.gz && cd ananicy-cpp-v1.1.1 && cmake -B "build" . -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr -DUSE_EXTERNAL_SPDLOG=ON -DUSE_EXTERNAL_JSON=ON -DUSE_EXTERNAL_FMTLIB=ON -DENABLE_SYSTEMD=OFF -DVERSION=1.1.1 && cmake --build build && doas cmake --install build --component Runtime && git clone --depth 1 https://github.com/CachyOS/ananicy-rules.git $HOME/stuffs/git/ananicy.d && doas rm -rf /etc/ananicy.d/ && doas cp -r $HOME/stuffs/git/ananicy.d /etc/ && doas cp -r $HOME/stuffs/git/dotfiles/void/services/ananicy-cpp/ /etc/sv/ && doas ln -s /etc/sv/ananicy-cpp/ /var/service && doas xbps-remove -RFfvy wget cmake json-c++ && rm -rf $HOME/ananicy-cpp-v1.1.1.tar.gz && rm -rf $HOME/ananicy-cpp-v1.1.1 && rm -rf $HOME/.wget-hsts

# preload [HDD ONLY]
#doas xbps-install -vy preload && doas ln -s /etc/sv/preload/ /var/service

###### OPTIMIZATIONS ######


###### WINDOW MANAGERS ######

# bspwm (X11)
doas xbps-install -vy sxhkd bspwm polybar i3lock-color xwallpaper xorg-server xf86-input-libinput xauth xinit xss-lock xset xsel xclip xdotool xrandr scrot rofi xcolor fontconfig-devel libX11-devel libXft-devel harfbuzz-devel && git clone --depth 1 https://github.com/phenax/bsp-layout.git $HOME/stuffs/git/bsp-layout && cd $HOME/stuffs/git/bsp-layout && doas make install && git clone --depth 1 https://github.com/pinitik1906/st.git $HOME/stuffs/git/st && cd $HOME/stuffs/git/st && make && doas make install && doas xbps-remove -ROoFfvy fontconfig-devel libX11-devel libXft-devel harfbuzz-devel

# river (Wayland)
#doas xbps-install -vy river Waybar wayland-protocols swaylock swaybg xorg-server-xwayland xdg-desktop-portal-wlr xdg-desktop-portal-gtk wl-clipboard wtype wlr-randr grim slurp tofi swayidle wlopm qt5-wayland qt6-wayland qt5ct qt6ct zenity ImageMagick foot && git clone --depth 1 https://github.com/jgmdev/wl-color-picker.git $HOME/stuffs/git/wl-color-picker && cd $HOME/stuffs/git/wl-color-picker && doas make install

###### WINDOW MANAGERS ######


# install your programs here
doas xbps-install -vy noto-fonts-ttf noto-fonts-emoji noto-fonts-cjk htop fastfetch neovim zathura zathura-pdf-poppler mpv lf pavucontrol brightnessctl imv gammastep yt-dlp mpd mpc ncmpcpp newsboat

# fixing mdocml (temporary)
doas makewhatis -a

# fixing bad font rendering
doas ln -s /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/

# install NetworkManager (optional. if you uncomment it, please use `nmtui` to connect)
#doas xbps-install -vy NetworkManager && doas rm -rf /var/service/wpa_supplicant && doas rm -rf /var/service/dhcpcd && doas ln -s /etc/sv/NetworkManager/ /var/service

# removing any orphaned git and packages
rm -rf $HOME/.bash_logout && rm -rf $HOME/.bash_history && rm -rf $HOME/.inputrc && rm -rf $HOME/stuffs/git/psd && rm -rf $HOME/stuffs/git/ananicy-cpp && rm -rf $HOME/stuffs/git/bsp-layout && rm -rf $HOME/stuffs/git/wl-color-picker && rm -rf $HOME/stuffs/git/ananicy.d && rm -rf $HOME/stuffs/git/st && doas xbps-remove -ROoFfvy && doas rm -rf /var/cache/xbps/* && doas rm -rf $HOME/.cache && doas vkpurge rm all

# some packages might not configured properly, consider fix this with xbps-reconfigure to all packages
doas xbps-reconfigure -fa

# trimming SSD if available
doas fstrim -av

# rebooting your pc
doas reboot
