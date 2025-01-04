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

# enable nonfree and multilib [GLIBC]
#sudo rm -rf /etc/xbps.d/00-repository-main.conf && echo "repository=https://repo-fastly.voidlinux.org/current" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/nonfree" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/multilib" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/multilib/nonfree" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null

# enable nonfree [MUSL]
#sudo rm -rf /etc/xbps.d/00-repository-main.conf && echo "repository=https://repo-fastly.voidlinux.org/current/musl" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/musl/nonfree" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null

###### REPO ######


# checking updates & syncing repos
sudo xbps-install -Suvy

# create folder for screenshooting, otherwise it won't work
mkdir -p $HOME/stuffs/pic/screenshots

# copying all conf to home folder
rm -rf $HOME/.config
rm -rf $HOME/.local
mkdir -p $HOME/.config
cp -r $HOME/stuffs/git/dotfiles/void/.config $HOME
cp -r $HOME/stuffs/git/dotfiles/void/.local $HOME

cp $HOME/stuffs/git/dotfiles/void/.bash_profile $HOME/.bash_profile
cp $HOME/stuffs/git/dotfiles/void/.Xresources $HOME/.Xresources
cp $HOME/stuffs/git/dotfiles/void/.xinitrc $HOME/.xinitrc
cp $HOME/stuffs/git/dotfiles/void/.bashrc $HOME/.bashrc

# copying all xorg conf to /etc/X11/xorg.conf.d/
sudo mkdir -p /etc/X11/xorg.conf.d
sudo cp $HOME/stuffs/git/dotfiles/void/20-intel.conf /etc/X11/xorg.conf.d/
sudo cp $HOME/stuffs/git/dotfiles/void/40-libinput.conf /etc/X11/xorg.conf.d/
sudo cp $HOME/stuffs/git/dotfiles/void/90-touchpad.conf /etc/X11/xorg.conf.d/

# installing opendoas & removing sudo
sudo rm -f /etc/doas.conf && echo "permit persist :wheel" | sudo tee -a /etc/doas.conf > /dev/null && sudo xbps-install -vy opendoas && doas xbps-remove -RFfvy sudo

# installing important dependencies
doas xbps-install -vy base-devel elogind polkit dbus opendoas xorg-minimal xorg-fonts linux-firmware pipewire alsa-pipewire mate-polkit gtk+3 gtk4 qt5-wayland qt6-wayland qt5ct ffmpeg playerctl dunst libnotify bash-completion rsync && doas mkdir -p /etc/alsa/conf.d && doas ln -s /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d && doas ln -s /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d && doas mkdir -p /etc/pipewire/pipewire.conf.d && doas ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/ && doas mkdir -p /etc/pipewire/pipewire.conf.d && doas ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/ && doas ln -s /etc/sv/rsyncd/ /var/service

# removing acpid and its service as it conflicts elogind
doas xbps-remove -RFfvy acpid && doas rm -rf /var/service/acpid

# enabling dbus for elogind and others
doas ln -s /etc/sv/dbus/ /var/service

# installing additional vulkan dependencies
doas xbps-install -vy vulkan-loader mesa-vulkan-lavapipe

# 32-bit vulkan dependencies [NEEDS MULTILIB REPO ENABLED, GLIBC ONLY]
#doas xbps-install -vy vulkan-loader-32bit mesa-vulkan-lavapipe-32bit

# clone madand's runit-services
git clone --depth 1 https://github.com/madand/runit-services.git $HOME/stuffs/git/runit-services


###### DRIVERS ######

# intel [NEEDS NONFREE REPO ENABLED]
#doas xbps-install -vy xf86-video-intel linux-firmware-intel mesa-dri mesa-vulkan-intel intel-video-accel libvdpau libvdpau-va-gl

# 32-bit intel [NEEDS MULTILIB REPO ENABLED, GLIBC ONLY]
#doas xbps-install -vy mesa-dri-32bit mesa-vulkan-intel-32bit libva-intel-driver-32bit libvdpau-32bit libvdpau-va-gl-32bit

# intel microcode (NEEDS NONFREE REPO ENABLED) [IMPORTANT]
#doas xbps-install -vy intel-ucode

# modern_amd [NEEDS NONFREE REPO ENABLED]
#doas xbps-install -vy xf86-video-amdgpu linux-firmware-amd mesa-dri mesa-vulkan-radeon mesa-vaapi mesa-vdpau

# 32-bit modern_amd [NEEDS MULTILIB REPO ENABLED, GLIBC ONLY]
#doas xbps-install -vy mesa-dri-32bit mesa-vulkan-radeon-32bit mesa-vaapi-32bit mesa-vdpau-32bit

# old_amd [NEEDS NONFREE REPO ENABLED]
#doas xbps-install -vy xf86-video-ati linux-firmware-amd mesa-dri amdvlk mesa-vaapi mesa-vdpau

# 32-bit old_amd [NEEDS MULTILIB REPO ENABLED, GLIBC ONLY]
#doas xbps-install -vy mesa-dri-32bit amdvlk-32bit mesa-vaapi-32bit mesa-vdpau-32bit

# modern_nvidia proprietary [NEEDS NONFREE REPO ENABLED]
#doas xbps-install -vy nvidia nvidia-dkms linux-firmware-nvidia nvidia-firmware nvidia-vaapi-driver mesa-vdpau mesa-dri nvidia-libs

# 32-bit modern_nvidia proprietary [NEEDS MULTILIB REPO ENABLED, GLIBC ONLY]
#doas xbps-install -vy mesa-vdpau-32bit mesa-dri-32bit nvidia-libs-32bit

# old_nvidia nouveau [NEEDS NONFREE REPO ENABLED]
#doas xbps-install -vy xf86-video-nouveau mesa-dri mesa-vdpau

# 32-bit old_nvidia nouveau [NEEDS MULTILIB REPO ENABLED, GLIBC ONLY]
#doas xbps-install -vy mesa-dri-32bit mesa-vdpau-32bit

###### DRIVERS ######


###### VOID-SRC ######

# enable nonfree and multilib [GLIBC]
#git clone --depth 1 https://github.com/void-linux/void-packages.git $HOME/stuffs/git/void-packages && cd $HOME/stuffs/git/void-packages && echo XBPS_ALLOW_RESTRICTED=yes >> $HOME/stuffs/git/void-packages/etc/conf && rm -rf $HOME/stuffs/git/void-packages/etc/xbps.d/repos-remote.conf && rm -rf $HOME/stuffs/git/void-packages/etc/xbps.d/repos-remote-x86_64-multilib.conf && echo "repository=https://repo-fastly.voidlinux.org/current" | tee -a $HOME/stuffs/git/void-packages/etc/xbps.d/repos-remote.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/bootstrap" | tee -a $HOME/stuffs/git/void-packages/etc/xbps.d/repos-remote.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/nonfree" | tee -a $HOME/stuffs/git/void-packages/etc/xbps.d/repos-remote.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/debug" | tee -a $HOME/stuffs/git/void-packages/etc/xbps.d/repos-remote.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/multilib" | tee -a $HOME/stuffs/git/void-packages/etc/xbps.d/repos-remote-x86_64-multilib > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/multilib/bootstrap" | tee -a $HOME/stuffs/git/void-packages/etc/xbps.d/repos-remote-x86_64-multilib > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/multilib/nonfree" | tee -a $HOME/stuffs/git/void-packages/etc/xbps.d/repos-remote-x86_64-multilib > /dev/null && ./xbps-src binary-bootstrap

# enable nonfree [MUSL]
#git clone --depth 1 https://github.com/void-linux/void-packages.git $HOME/stuffs/git/void-packages && cd $HOME/stuffs/git/void-packages && echo XBPS_ALLOW_RESTRICTED=yes >> $HOME/stuffs/git/void-packages/etc/conf && rm -rf $HOME/stuffs/git/void-packages/etc/xbps.d/repos-remote-musl.conf && echo "repository=https://repo-fastly.voidlinux.org/current/musl" | tee -a $HOME/stuffs/git/void-packages/etc/xbps.d/repos-remote-musl.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/musl/bootstrap" | tee -a $HOME/stuffs/git/void-packages/etc/xbps.d/repos-remote-musl.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/musl/nonfree" | tee -a $HOME/stuffs/git/void-packages/etc/xbps.d/repos-remote-musl.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/musl" | tee -a $HOME/stuffs/git/void-packages/etc/xbps.d/repos-remote-musl.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/musl/debug" | tee -a $HOME/stuffs/git/void-packages/etc/xbps.d/repos-remote-musl.conf > /dev/null && ./xbps-src binary-bootstrap

###### VOID-SRC ######


###### OPTIONAL ######

# msttcorefonts [NEEDS VOID-SRC ENABLED]
#cd $HOME/stuffs/git/void-packages && ./xbps-src -f pkg msttcorefonts && doas xbps-install -Suvy --repository hostdir/binpkgs/nonfree/ msttcorefonts

# enable backlight service for saving previous brightness you've set after rebooting your pc
#doas cp -r $HOME/stuffs/git/runit-services/backlight /etc/sv/ && doas ln -s /etc/sv/backlight/ /var/service

# thinkfan (please enable thinkfan service after you reboot your pc) [THINKPADS ONLY]
#doas cp -r $HOME/stuffs/git/runit-services/thinkfan /etc/sv/ && doas xbps-install -Suvy thinkfan && doas cp $HOME/stuffs/git/dotfiles/void/thinkfan.yaml /etc/

# thermald (supports tlp) [INTEL ONLY]
#doas xbps-install -vy thermald && doas ln -s /etc/sv/thermald/ /var/service

# tlp
#doas xbps-install -vy tlp && doas ln -s /etc/sv/tlp/ /var/service

# bluetooth with pipewire and alsa
#doas xbps-install -vy bluez bluez-alsa libspa-bluetooth && doas ln -s /etc/sv/bluetoothd/ /var/service

# bsp-layout (MASTER STACK)
#doas xbps-install -vy bc && git clone --depth 1 https://github.com/phenax/bsp-layout.git $HOME/stuffs/git/bsp-layout && cd $HOME/stuffs/git/bsp-layout && doas make install

###### OPTIONAL ######


###### WINDOW MANAGERS ######

# bspwm (X11)
#doas xbps-install -vy sxhkd bspwm polybar i3lock-color xinit xrdb xss-lock xset xsel xclip xdotool xrandr scrot rofi lxappearance xcolor rxvt-unicode

# river (Wayland)
doas xbps-install -vy river Waybar swaylock xorg-server-xwayland xdg-desktop-portal-wlr xdg-desktop-portal-gtk wl-clipboard wtype wlr-randr grim slurp tofi swayidle wlopm zenity ImageMagick nwg-look foot && git clone --depth 1 https://github.com/jgmdev/wl-color-picker.git $HOME/stuffs/git/wl-color-picker && cd $HOME/stuffs/git/wl-color-picker && doas make install

###### WINDOW MANAGERS ######


# install your programs here
doas xbps-install -vy arc-theme papirus-icon-theme noto-fonts-ttf noto-fonts-emoji noto-fonts-cjk htop fastfetch neovim zathura zathura-pdf-poppler mpv pcmanfm xarchiver ufw pavucontrol brightnessctl imv acpi gammastep

# enable ufw with recommended settings by chris_titus
doas ln -s /etc/sv/ufw/ /var/service && doas ufw limit 22/tcp && doas ufw allow 80/tcp && doas ufw allow 443/tcp && doas ufw default deny incoming && doas ufw default allow outgoing && doas ufw enable

# fix bad font rendering
doas ln -s /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/

# install NetworkManager (optional. if you uncomment it, please use `nmtui` to connect)
#doas xbps-install -vy NetworkManager && doas rm -rf /var/service/wpa_supplicant && doas rm -rf /var/service/dhcpcd && doas ln -s /etc/sv/NetworkManager/ /var/service && doas usermod -aG network $USER

# remove any orphaned packages
doas xbps-remove -ROovy

# some packages might not configured properly, consider fix this with xbps-reconfigure to all packages.
doas xbps-reconfigure -fa

# rebooting your pc
doas reboot
