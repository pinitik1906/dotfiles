#!/bin/sh


###### REPO ######

# enable nonfree and multilib [GLIBC]
#sudo rm -rf /etc/xbps.d/00-repository-main.conf && echo "repository=https://repo-fastly.voidlinux.org/current" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/nonfree" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/multilib" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/multilib/nonfree" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null

# enable nonfree [MUSL]
#sudo rm -rf /etc/xbps.d/00-repository-main.conf && echo "repository=https://repo-fastly.voidlinux.org/current/musl" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/musl/nonfree" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null

###### REPO ######


# remove irqbalance as it reduces performance
sudo xbps-remove -ROoFfvy irqbalance

# checking updates
sudo xbps-install -Suvy

# installing important dependencies
sudo xbps-install -Suvy base-devel elogind polkit dbus opendoas xorg-minimal xorg-fonts linux-firmware pipewire alsa-pipewire mate-polkit ffmpeg && sudo mkdir -p /etc/alsa/conf.d && sudo ln -s /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d && sudo ln -s /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d && sudo mkdir -p /etc/pipewire/pipewire.conf.d && sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/ && sudo mkdir -p /etc/pipewire/pipewire.conf.d && sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/

# removing acpid and its service as it conflicts elogind
sudo xbps-remove -ROoFfvy acpid && sudo rm -rf /var/service/acpid

# enabling dbus for elogind and others
sudo ln -s /etc/sv/dbus/ /var/service

# installing additional vulkan dependencies
sudo xbps-install -Suvy vulkan-loader mesa-vulkan-lavapipe

# 32-bit vulkan dependencies [NEEDS MULTILIB REPO ENABLED, GLIBC ONLY]
#sudo xbps-install -Suvy vulkan-loader-32bit mesa-vulkan-lavapipe-32bit

# clone madand's runit-services (you have an option to enable this for the optional sections)
#git clone --depth 1 https://github.com/madand/runit-services.git ~/stuffs/git/runit-services


###### DRIVERS ######

# intel [NEEDS NONFREE REPO ENABLED]
#sudo xbps-install -Suvy xf86-video-intel linux-firmware-intel mesa-dri mesa-vulkan-intel intel-video-accel libvdpau libvdpau-va-gl

# 32-bit intel [NEEDS MULTILIB REPO ENABLED, GLIBC ONLY]
#sudo xbps-install -Suvy mesa-dri-32bit mesa-vulkan-intel-32bit libva-intel-driver-32bit libvdpau-32bit libvdpau-va-gl-32bit

# intel microcode (NEEDS NONFREE REPO ENABLED) [IMPORTANT]
#sudo xbps-install -Suvy intel-ucode

# modern_amd [NEEDS NONFREE REPO ENABLED]
#sudo xbps-install -Suvy xf86-video-amdgpu linux-firmware-amd mesa-dri mesa-vulkan-radeon mesa-vaapi mesa-vdpau

# 32-bit modern_amd [NEEDS MULTILIB REPO ENABLED, GLIBC ONLY]
#sudo xbps-install -Suvy mesa-dri-32bit mesa-vulkan-radeon-32bit mesa-vaapi-32bit mesa-vdpau-32bit

# old_amd [NEEDS NONFREE REPO ENABLED]
#sudo xbps-install -Suvy xf86-video-ati linux-firmware-amd mesa-dri amdvlk mesa-vaapi mesa-vdpau

# 32-bit old_amd [NEEDS MULTILIB REPO ENABLED, GLIBC ONLY]
#sudo xbps-install -Suvy mesa-dri-32bit amdvlk-32bit mesa-vaapi-32bit mesa-vdpau-32bit

# modern_nvidia proprietary [NEEDS NONFREE REPO ENABLED]
#sudo xbps-install -Suvy nvidia nvidia-dkms linux-firmware-nvidia nvidia-firmware nvidia-vaapi-driver mesa-vdpau mesa-dri nvidia-libs

# 32-bit modern_nvidia proprietary [NEEDS MULTILIB REPO ENABLED, GLIBC ONLY]
#sudo xbps-install -Suvy mesa-vdpau-32bit mesa-dri-32bit nvidia-libs-32bit

# old_nvidia nouveau [NEEDS NONFREE REPO ENABLED]
#sudo xbps-install -Suvy xf86-video-nouveau mesa-dri mesa-vdpau

# 32-bit old_nvidia nouveau [NEEDS MULTILIB REPO ENABLED, GLIBC ONLY]
#sudo xbps-install -Suvy mesa-dri-32bit mesa-vdpau-32bit

###### DRIVERS ######


###### VOID-SRC ######

# enable nonfree and multilib [GLIBC]
#git clone --depth 1 https://github.com/void-linux/void-packages.git ~/stuffs/git/void-packages && cd ~/stuffs/git/void-packages && echo XBPS_ALLOW_RESTRICTED=yes >> ~/stuffs/git/void-packages/etc/conf && rm -rf ~/stuffs/git/void-packages/etc/xbps.d/repos-remote.conf && rm -rf ~/stuffs/git/void-packages/etc/xbps.d/repos-remote-x86_64-multilib.conf && echo "repository=https://repo-fastly.voidlinux.org/current" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/bootstrap" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/nonfree" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/debug" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/multilib" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote-x86_64-multilib > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/multilib/bootstrap" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote-x86_64-multilib > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/multilib/nonfree" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote-x86_64-multilib > /dev/null && ./xbps-src binary-bootstrap

# enable nonfree [MUSL]
#git clone --depth 1 https://github.com/void-linux/void-packages.git ~/stuffs/git/void-packages && cd ~/stuffs/git/void-packages && echo XBPS_ALLOW_RESTRICTED=yes >> ~/stuffs/git/void-packages/etc/conf && rm -rf ~/stuffs/git/void-packages/etc/xbps.d/repos-remote-musl.conf && echo "repository=https://repo-fastly.voidlinux.org/current/musl" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote-musl.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/musl/bootstrap" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote-musl.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/musl/nonfree" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote-musl.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/musl" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote-musl.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/musl/debug" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote-musl.conf > /dev/null && ./xbps-src binary-bootstrap

###### VOID-SRC ######


###### OPTIONAL ######

# msttcorefonts [NEEDS VOID-SRC ENABLED]
#cd ~/stuffs/git/void-packages && ./xbps-src -f pkg msttcorefonts && sudo xbps-install -Suvy --repository hostdir/binpkgs/nonfree/ msttcorefonts

# enable backlight service for saving previous brightness you've set after rebooting your pc
#sudo cp -r ~/stuffs/git/runit-services/backlight /etc/sv/ && sudo ln -s /etc/sv/backlight/ /var/service

# thinkfan [THINKPADS ONLY]
#sudo cp -r ~/stuffs/git/runit-services/thinkfan /etc/sv/ && sudo xbps-install -Suvy thinkfan && sudo ln -s /etc/sv/thinkfan/ /var/service

# thermald (supports tlp) [INTEL ONLY]
#sudo xbps-install -Suvy thermald && sudo ln -s /etc/sv/thermald/ /var/service

# tlp
#sudo xbps-install -Suvy tlp && sudo ln -s /etc/sv/tlp/ /var/service

# bluetooth with pipewire and alsa
#sudo xbps-install -Suvy bluez bluez-alsa libspa-bluetooth && sudo ln -s /etc/sv/bluetoothd/ /var/service

# bsp-layout (MASTER STACK)
#sudo xbps-install -Suvy bc && git clone --depth 1 https://github.com/phenax/bsp-layout.git ~/stuffs/git/bsp-layout && cd ~/stuffs/git/bsp-layout && sudo make install

###### OPTIONAL ######


###### WINDOW MANAGERS ######

# bspwm (X11)
#sudo xbps-install -Suvy sxhkd bspwm polybar i3lock-color xinit xrdb xcolor xss-lock xset xsel xclip xdotool xrandr scrot rofi rxvt-unicode

# river (Wayland)
#sudo xbps-install -Suvy river Waybar swaylock xorg-server-xwayland xdg-desktop-portal-wlr xdg-desktop-portal-gtk wl-clipboard wtype wlr-randr grim slurp tofi foot swayidle wlopm

###### WINDOW MANAGERS ######


# install your programs here
sudo xbps-install -Suvy nwg-look noto-fonts-ttf noto-fonts-emoji noto-fonts-cjk htop ufetch neovim zathura zathura-pdf-poppler mpv ranger ufw pavucontrol dunst libnotify brightnessctl nsxiv acpi ueberzug ffmpegthumbnailer

# enable ufw with recommended settings by chris_titus
sudo ln -s /etc/sv/ufw/ /var/service && sudo ufw limit 22/tcp && sudo ufw allow 80/tcp && sudo ufw allow 443/tcp && sudo ufw default deny incoming && sudo ufw default allow outgoing && sudo ufw enable

# sudo alternative (doas) [RECOMMENDED]
sudo rm -f /etc/doas.conf && echo "permit persist :wheel" | sudo tee -a /etc/doas.conf > /dev/null

# fix bad font rendering
sudo ln -s /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/

# install NetworkManager (optional. if you uncomment it, please use `nmtui` to connect)
#sudo xbps-install -Suvy NetworkManager && sudo rm -rf /var/service/wpa_supplicant && sudo rm -rf /var/service/dhcpcd && sudo ln -s /etc/sv/NetworkManager/ /var/service && sudo usermod -aG network $(whoami)

# remove any orphaned packages
sudo xbps-remove -ROoFfvy

# removing sudo
sudo xbps-remove -ROoFfvy sudo

# some packages might not configured properly, consider fix this with xbps-reconfigure to all packages.
doas xbps-reconfigure -fa
