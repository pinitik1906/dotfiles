#!/bin/bash

# installing updates
sudo xbps-install -Suvy


###### DRIVERS OPTIONS ######

# install intel drivers
# sudo xbps-install -Suvy xf86-video-intel linux-firmware-intel mesa-dri vulkan-loader mesa-vulkan-intel intel-video-accel

# install modern_amd drivers
# sudo xbps-install -Suvy xf86-video-amdgpu linux-firmware-amd mesa-dri vulkan-loader mesa-vulkan-radeon mesa-vaapi mesa-vdpau

# install old_amd drivers
# sudo xbps-install -Suvy xf86-video-ati linux-firmware-amd mesa-dri vulkan-loader amdvlk mesa-vaapi mesa-vdpau

# install modern_nvidia drivers (NEEDS TO ENABLE NONFREE REPO AT OPTIONAL SECTIONS)
# sudo xbps-install -Suvy nvidia nvidia-dkms

# install bumblebee (ONLY FOR PROPRIETARY NVIDIA DRIVERS AND NVIDIA OPTIMUS SUPPORT)
# sudo xbps-install -Suvy bumblebee bbswitch && sudo ln -s /etc/sv/bumblebeed

# install old_nvidia's nouveau neccesary packages
# sudo xbps-install -Suvy xf86-video-nouveau mesa-dri  

###### GRAPHICS OPTIONS ######

###### VOID-SRC ######

# enabling void-src with nonfree and multilib (glibc)
# git clone --depth 1 https://github.com/void-linux/void-packages.git ~/git/void-packages && cd ~/git/void-packages && ./xbps-src binary-bootstrap && echo XBPS_ALLOW_RESTRICTED=yes >> ~/git/void-packages/etc/conf && rm -rf ~/git/void-packages/etc/xbps.d/repos-remote.conf && rm -rf ~/git/void-packages/etc/xbps.d/repos-remote-x86_64-multilib.conf && echo "repository=https://repo-fastly.voidlinux.org/current" | sudo tee -a ~/git/void-packages/etc/xbps.d/repos-remote.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/bootstrap" | sudo tee -a ~/git/void-packages/etc/xbps.d/repos-remote.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/nonfree" | sudo tee -a ~/git/void-packages/etc/xbps.d/repos-remote.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/debug" | sudo tee -a ~/git/void-packages/etc/xbps.d/repos-remote.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/multilib" | sudo tee -a ~/git/void-packages/etc/xbps.d/repos-remote-x86_64-multilib > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/multilib/bootstrap" | sudo tee -a ~/git/void-packages/etc/xbps.d/repos-remote-x86_64-multilib > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/multilib/nonfree" | sudo tee -a ~/git/void-packages/etc/xbps.d/repos-remote-x86_64-multilib > /dev/null

# enabling void-src with nonfree (musl)
# git clone --depth 1 https://github.com/void-linux/void-packages.git ~/git/void-packages && cd ~/git/void-packages && ./xbps-src binary-bootstrap && echo XBPS_ALLOW_RESTRICTED=yes >> ~/git/void-packages/etc/conf &&  rm -rf ~/git/void-packages/etc/xbps.d/repos-remote-musl.conf && echo "repository=https://repo-fastly.voidlinux.org/current/musl" | sudo tee -a ~/git/void-packages/etc/xbps.d/repos-remote-musl.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/musl/bootstrap" | sudo tee -a ~/git/void-packages/etc/xbps.d/repos-remote-musl.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/musl/nonfree" | sudo tee -a ~/git/void-packages/etc/xbps.d/repos-remote-musl.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/musl" | sudo tee -a ~/git/void-packages/etc/xbps.d/repos-remote-musl.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/musl/debug" | sudo tee -a ~/git/void-packages/etc/xbps.d/repos-remote-musl.conf > /dev/null

###### VOID-SRC ######


###### OPTIONAL SECTIONS ######

# enabling nonfree and multilib repos (glibc)
# sudo rm -rf /etc/xbps.d/00-repository-main.conf && echo "repository=https://repo-fastly.voidlinux.org/current" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/nonfree" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/multilib" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/multilib/nonfree" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null

# enabling nonfree repo (musl)
# sudo rm -rf /etc/xbps.d/00-repository-main.conf && echo "repository=https://repo-fastly.voidlinux.org/current/musl" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/musl/nonfree" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null

# installing intel microcode (NEEDS ENABLING NONFREE REPO)
# sudo xbps-install -Suvy intel-ucode && sudo xbps-reconfigure -f $(xbps-query -l | grep linux)

# installing the latest kernel (you need to reboot and boot it to latest kernel, then do `sudo vkpurge rm all` and `sudo xbps-remove -ROoFfvy linux linux-headers`)
# sudo xbps-install -Suvy linux-mainline linux-mainline-headers

# installing msttcorefonts (NEEDS VOID-SRC OPTION ENABLED)
# cd ~/git/void-packages && ./xbps-src -f pkg msttcorefonts && sudo xbps-install -Suvy --repository hostdir/binpkgs/nonfree/ msttcorefonts

# installing and enabling zramen
# sudo xbps-install -Suvy zramen && sudo ln -s /etc/sv/zramen/ /var/service

# enable backlight for saving previous brightness you've set after rebooting your pc
# git clone --depth 1 https://github.com/madand/runit-services.git ~/git/runit-services && sudo cp -r ~/git/runit-services/backlight /etc/sv/ && sudo ln -s /etc/sv/backlight/ /var/service

# installing and enabling psd (profile-sync-daemon) (optional but recommended as it reduces HDD/SSD calls, thus speeding up the browser)
# sudo xbps-install -Suvy coreutils findutils kmod rsync && sudo ln -s /etc/sv/rsyncd/ /var/service && git clone --depth 1 https://github.com/graysky2/profile-sync-daemon.git ~/git/profile-sync-daemon && cd ~/git/profile-sync-daemon && make && sudo make install && sudo rm -rf /usr/lib/systemd && git clone --depth 1 https://github.com/madand/runit-services ~/git/runit-services && sudo cp -r ~/git/runit-services/psd /etc/sv/ && sudo ln -s /etc/sv/psd/ /var/service

# installing and enabling thinkfan (thinkpads only)
# git clone --depth 1 https://github.com/madand/runit-services.git ~/git/runit-services && sudo cp -r ~/git/runit-services/thinkfan /etc/sv/ && sudo xbps-install -Suvy thinkfan && sudo ln -s /etc/sv/thinkfan/ /var/service

# installing and enabling thermald (also supports tlp)
# sudo xbps-install -Suvy thermald && sudo ln -s /etc/sv/thermald/ /var/service

# replace wpa_supplicant with NetworkManager
# sudo xbps-install -Suvy NetworkManager && sudo ln -s /etc/sv/NetworkManager/ /var/service && sudo rm -rf /var/service/wpa_supplicant && sudo rm -rf /var/service/dhcpcd

# installing tlp (install tlp-rdw if you enabled NetworkManager)
# sudo xbps-install -Suvy tlp && sudo ln -s /etc/sv/tlp/ /var/service

# enabling bluetooth with pipewire and alsa
# sudo xbps-install -Suvy bluez bluez-alsa libspa-bluetooth && sudo ln -s /etc/sv/bluetoothd/ /var/service

# installing alsa-pipewire
# sudo xbps-install -Suvy alsa-pipewire && sudo mkdir -p /etc/alsa/conf.d && sudo ln -s /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d && sudo ln -s /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d

###### OPTIONAL SECTIONS ######


###### WINDOW MANAGERS ######

# install bspwm (X11)
# sudo xbps-install -Suvy bspwm sxhkd polybar rxvt-unicode i3lock xinit xrdb xcolor xss-lock xsel xclip xdotool xrandr ueberzug ffmpegthumbnailer redshift scrot

# install hyprland (glibc_Wayland)
# sudo rm -rf /etc/xbps.d/00-hyprland-void-glibc.conf && sudo echo "repository=https://raw.githubusercontent.com/Makrennel/hyprland-void/repository-x86_64-glibc" | sudo tee -a /etc/xbps.d/00-hyprland-void-glibc.conf > /dev/null && sudo xbps-install -Suvy xorg-server-xwayland hyprland hyprpicker hyprlock Waybar xdg-desktop-portal-hyprland foot wlsunset wl-clipboard wtype grim slurp && git clone --depth 1 https://github.com/Gustash/hyprshot.git ~/git/hyprshot && ln -s ~/git/hyprshot ~/.local/bin/ && chmod +x ~/git/hyprshot/hyprshot

# install hyprland (musl_Wayland)
# sudo rm -rf /etc/xbps.d/00-hyprland-void-musl.conf && sudo echo "repository=https://raw.githubusercontent.com/Makrennel/hyprland-void/repository-x86_64-musl" | sudo tee -a /etc/xbps.d/00-hyprland-void-musl.conf > /dev/null && sudo xbps-install -Suvy xorg-server-xwayland hyprland hyprpicker hyprlock Waybar xdg-desktop-portal-hyprland foot wlsunset wl-clipboard wtype grim slurp && git clone --depth 1 https://github.com/Gustash/hyprshot.git ~/git/hyprshot && ln -s ~/git/hyprshot ~/.local/bin/ && chmod +x ~/git/hyprshot/hyprshot

###### WINDOW MANAGERS ######


# installing dependencies & programs
sudo xbps-install -Suvy elogind polkit dbus xorg-minimal xorg-fonts linux-firmware pipewire noto-fonts-ttf noto-fonts-emoji noto-fonts-cjk fastfetch neovim zathura zathura-pdf-poppler mpv udisks2 ranger ufw pavucontrol dunst rofi rofi-calc rofi-emoji xtools brightnessctl nsxiv zig gcc clang ffmpeg opendoas acpi lxsession

# disabling acpid service as it conflicts elogind
sudo xbps-remove -ROoFfvy && sudo rm -rf /var/service/acpid

# enabling important services
sudo ln -s /etc/sv/dbus/ /var/service && sudo ln -s /etc/sv/ufw/ /var/service

# making pipewire usable
sudo mkdir -p /etc/pipewire/pipewire.conf.d && sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/ && sudo mkdir -p /etc/pipewire/pipewire.conf.d && sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/

# ufw recommended settings
sudo ufw limit 22/tcp && sudo ufw allow 80/tcp && sudo ufw allow 443/tcp && sudo ufw default deny incoming && sudo ufw default allow outgoing && sudo ufw enable

# sudo alternative (opendoas/doas), simple yet secure and minimal (recommended)
sudo rm -f /etc/doas.conf && echo "permit $(whoami) as root" | sudo tee -a /etc/doas.conf > /dev/null && echo "permit :wheel" | sudo tee -a /etc/doas.conf > /dev/null

# fix bad font rendering
sudo ln -s /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/ && sudo xbps-reconfigure -f fontconfig

# restarting services after updating the whole packages 
xcheckrestart

# some packages might not configured properly, consider fix this with xbps-reconfigure to all packages.
sudo xbps-reconfigure -fa

# removing sudo
sudo xbps-remove -ROoFfvy sudo
