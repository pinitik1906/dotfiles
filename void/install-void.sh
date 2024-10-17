#!/bin/bash


###### REPO ######

# enabling nonfree and multilib repos (glibc)
# sudo rm -rf /etc/xbps.d/00-repository-main.conf && echo "repository=https://repo-fastly.voidlinux.org/current" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/nonfree" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/multilib" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/multilib/nonfree" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null

# enabling nonfree repo (musl)
# sudo rm -rf /etc/xbps.d/00-repository-main.conf && echo "repository=https://repo-fastly.voidlinux.org/current/musl" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/musl/nonfree" | sudo tee -a /etc/xbps.d/00-repository-main.conf > /dev/null

###### REPO ######

# remove irqbalance as it reduces performance
sudo xbps-remove -ROoFfvy irqbalance

# checking updates
sudo xbps-install -Suvy

# installing important dependencies
sudo xbps-install -Suvy elogind polkit dbus make xdg-desktop-portal-gtk

# removing acpid and its service as it conflicts elogind
sudo xbps-remove -ROoFfvy acpid && sudo rm -rf /var/service/acpid

# enabling dbus for elogind and others
sudo ln -s /etc/sv/dbus/ /var/service

# clone madand's runit-services (you have an option to enable this for the optional sections)
# git clone --depth 1 https://github.com/madand/runit-services.git ~/stuffs/git/runit-services

###### DRIVERS ######

# install intel drivers
# sudo xbps-install -Suvy xf86-video-intel linux-firmware-intel mesa-dri vulkan-loader mesa-vulkan-intel intel-video-accel

# install intel microcode (NEEDS ENABLING NONFREE REPO)
# sudo xbps-install -Suvy intel-ucode

# install modern_amd drivers
# sudo xbps-install -Suvy xf86-video-amdgpu linux-firmware-amd mesa-dri vulkan-loader mesa-vulkan-radeon mesa-vaapi mesa-vdpau

# install old_amd drivers
# sudo xbps-install -Suvy xf86-video-ati linux-firmware-amd mesa-dri vulkan-loader amdvlk mesa-vaapi mesa-vdpau

# install modern_nvidia proprietary drivers (NEEDS TO ENABLE NONFREE REPO AT OPTIONAL SECTIONS)
# sudo xbps-install -Suvy nvidia nvidia-dkms

# install bumblebee (ONLY FOR MODERN NVIDIA DRIVERS AND NVIDIA OPTIMUS SUPPORT)
# sudo xbps-install -Suvy bumblebee bbswitch && sudo groupadd bumblebee && sudo gpasswd -a $(whoami) bumblebee && sudo ln -s /etc/sv/bumblebeed /var/service

# install old_nvidia nouveau neccesary packages
# sudo xbps-install -Suvy xf86-video-nouveau mesa-dri  

###### DRIVERS ######


###### VOID-SRC ######

# enabling void-src with nonfree and multilib (glibc)
# git clone --depth 1 https://github.com/void-linux/void-packages.git ~/stuffs/git/void-packages && cd ~/stuffs/git/void-packages && echo XBPS_ALLOW_RESTRICTED=yes >> ~/stuffs/git/void-packages/etc/conf && rm -rf ~/stuffs/git/void-packages/etc/xbps.d/repos-remote.conf && rm -rf ~/stuffs/git/void-packages/etc/xbps.d/repos-remote-x86_64-multilib.conf && echo "repository=https://repo-fastly.voidlinux.org/current" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/bootstrap" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/nonfree" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/debug" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/multilib" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote-x86_64-multilib > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/multilib/bootstrap" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote-x86_64-multilib > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/multilib/nonfree" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote-x86_64-multilib > /dev/null && ./xbps-src binary-bootstrap

# enabling void-src with nonfree (musl)
# git clone --depth 1 https://github.com/void-linux/void-packages.git ~/stuffs/git/void-packages && cd ~/stuffs/git/void-packages && echo XBPS_ALLOW_RESTRICTED=yes >> ~/stuffs/git/void-packages/etc/conf && rm -rf ~/stuffs/git/void-packages/etc/xbps.d/repos-remote-musl.conf && echo "repository=https://repo-fastly.voidlinux.org/current/musl" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote-musl.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/musl/bootstrap" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote-musl.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/musl/nonfree" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote-musl.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/musl" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote-musl.conf > /dev/null && echo "repository=https://repo-fastly.voidlinux.org/current/musl/debug" | tee -a ~/stuffs/git/void-packages/etc/xbps.d/repos-remote-musl.conf > /dev/null && ./xbps-src binary-bootstrap

###### VOID-SRC ######


###### OPTIONAL ######

# install msttcorefonts (NEEDS VOID-SRC OPTION ENABLED)
# cd ~/stuffs/git/void-packages && ./xbps-src -f pkg msttcorefonts && sudo xbps-install -Suvy --repository hostdir/binpkgs/nonfree/ msttcorefonts

# install earlyoom (RECOMMENDED)
sudo xbps-install -Suvy earlyoom && sudo ln -s /etc/sv/earlyoom /var/service

# enable backlight for saving previous brightness you've set after rebooting your pc
# sudo cp -r ~/stuffs/git/runit-services/backlight /etc/sv/ && sudo ln -s /etc/sv/backlight/ /var/service

# install and enable thinkfan (THINKPADS ONLY)
# sudo cp -r ~/stuffs/git/runit-services/thinkfan /etc/sv/ && sudo xbps-install -Suvy thinkfan && sudo ln -s /etc/sv/thinkfan/ /var/service

# install and enable thermald (also supports tlp)
# sudo xbps-install -Suvy thermald && sudo ln -s /etc/sv/thermald/ /var/service

# install and enable tlp
# sudo xbps-install -Suvy tlp && sudo ln -s /etc/sv/tlp/ /var/service

# install and enable bluetooth with pipewire and alsa
# sudo xbps-install -Suvy bluez bluez-alsa libspa-bluetooth && sudo ln -s /etc/sv/bluetoothd/ /var/service

# install alsa-pipewire
# sudo xbps-install -Suvy alsa-pipewire && sudo mkdir -p /etc/alsa/conf.d && sudo ln -s /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d && sudo ln -s /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d

###### OPTIONAL ######


###### WINDOW MANAGERS ######

# install bspwm (X11)
# sudo xbps-install -Suvy bspwm sxhkd polybar alacritty i3lock xinit xcolor xss-lock xsel xclip xdotool xrandr ueberzug ffmpegthumbnailer redshift scrot

# install hyprland (glibc_Wayland)
# sudo rm -rf /etc/xbps.d/00-hyprland-void-glibc.conf && sudo echo "repository=https://raw.githubusercontent.com/Makrennel/hyprland-void/repository-x86_64-glibc" | sudo tee -a /etc/xbps.d/00-hyprland-void-glibc.conf > /dev/null && sudo xbps-install -Suvy xorg-server-xwayland hyprland hyprpicker hyprlock Waybar xdg-desktop-portal-hyprland alacritty wlsunset wl-clipboard wtype grim slurp && git clone --depth 1 https://github.com/Gustash/hyprshot.git ~/stuffs/git/hyprshot && cp -r ~/stuffs/git/hyprshot/hyprshot ~/.local/bin/ && chmod +x ~/stuffs/git/hyprshot/hyprshot

# install hyprland (musl_Wayland)
# sudo rm -rf /etc/xbps.d/00-hyprland-void-musl.conf && sudo echo "repository=https://raw.githubusercontent.com/Makrennel/hyprland-void/repository-x86_64-musl" | sudo tee -a /etc/xbps.d/00-hyprland-void-musl.conf > /dev/null && sudo xbps-install -Suvy xorg-server-xwayland hyprland hyprpicker hyprlock Waybar xdg-desktop-portal-hyprland foot wlsunset wl-clipboard wtype grim slurp && git clone --depth 1 https://github.com/Gustash/hyprshot.git ~/stuffs/git/hyprshot && cp -r ~/stuffs/git/hyprshot/hyprshot ~/.local/bin/ && chmod +x ~/stuffs/git/hyprshot/hyprshot

###### WINDOW MANAGERS ######


# install your programs here
sudo xbps-install -Suvy xorg-minimal xorg-fonts linux-firmware pipewire noto-fonts-ttf noto-fonts-emoji noto-fonts-cjk htop fastfetch neovim zathura zathura-pdf-poppler mpv ranger ufw pavucontrol dunst rofi rofi-calc rofi-emoji brightnessctl nsxiv ffmpeg opendoas acpi lxsession

# enable ufw with recommended settings by chris_titus
sudo ln -s /etc/sv/ufw/ /var/service && sudo ufw limit 22/tcp && sudo ufw allow 80/tcp && sudo ufw allow 443/tcp && sudo ufw default deny incoming && sudo ufw default allow outgoing && sudo ufw enable

# make pipewire usable
sudo mkdir -p /etc/pipewire/pipewire.conf.d && sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/ && sudo mkdir -p /etc/pipewire/pipewire.conf.d && sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/

# sudo alternative (opendoas/doas), simple yet secure and minimal (recommended)
sudo rm -f /etc/doas.conf && echo "permit persist :wheel" | sudo tee -a /etc/doas.conf > /dev/null

# fix bad font rendering
sudo ln -s /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/

# install NetworkManager (optional. if you uncomment it, please use `nmtui` to connect)
# sudo xbps-install -Suvy NetworkManager && sudo rm -rf /var/service/wpa_supplicant && sudo rm -rf /var/service/dhcpcd && sudo ln -s /etc/sv/NetworkManager/ /var/service && sudo usermod -aG network $(whoami)

# remove any orphaned packages
sudo xbps-remove -ROoFfvy

# removing sudo
sudo xbps-remove -ROoFfvy sudo

# some packages might not configured properly, consider fix this with xbps-reconfigure to all packages.
doas xbps-reconfigure -fa
