![ss-1](screenshot/ss-1.png)
![ss-2](screenshot/ss-2.png)

# content

- [programs i use](https://github.com/pinitik1906/dotfiles#programs-i-use)
- [faq](https://github.com/pinitik1906/dotfiles#faq)
- [quick links](https://github.com/pinitik1906/dotfiles#quick-links)

## programs i use

- `bspwm` / `river`
- `polybar` / `waybar`
- `st` / `foot`
- `rofi` / `tofi`
- `bash`
- `dunst`
- `fastfetch`
- `htop`
- `neovim`
- `lf`
- `mpv`
- `mpd` w/ `ncmpcpp`
- `newsboat`
- `zathura`
- `pipewire`

### install
to get my dotfiles, type

```
git clone --depth 1 https://github.com/pinitik1906/dotfiles.git $HOME/stuffs/git/dotfiles
```

### update
to update my dotfiles (either check it weekly or monthly), type

```
cd $HOME/stuffs/git/dotfiles && git pull
```

## faq

### weird yellow/red color on my monitor
it is a program `gammastep` helps your eye with less eye-strains. if you want to remove, use the command below:

**artix**
```
sudo pacman -Rns gammastep
```

**void**
```
sudo xbps-remove -ROo gammastep
```

### proprietary NVIDIA on Wayland for artix
this is needed to make wayland compositors to function properly, referencing this [website](https://linuxiac.com/nvidia-with-wayland-on-arch-setup-guide/) but friendly since I did some preconfiguration. (i will choose neovim for this tutorial)

uncomment inside my `.bash_profile` in `nvidia tweaks` and `direct backend for nvidia` by removing a hashtag and rename in `vaapi & vdpau env` from both `i965,va_gl` to `nvidia`, so it will look like this

```
nvim $HOME/.bash_profile
```

ex.

```
# nvidia tweaks
export __EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/10_nvidia.json
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia

# vaapi & vdpau env
export LIBVA_DRIVER_NAME=nvidia
export VDPAU_DRIVER=nvidia

# direct backend for nvidia
export NVD_LOG=0
export NVD_BACKEND=direct
```

put this on `/etc/mkinitcpio.conf` with your favorite terminal editor and find & remove `kms` in `HOOKS` section

```
sudo nvim /etc/mkinitcpio.conf
```

```
MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
```

and then do,

```
sudo mkinitcpio -P && sudo update-grub
```

finally, reboot your pc and check if NVIDIA DRM were set correctly

```
sudo cat /sys/module/nvidia_drm/parameters/modeset
```

### unofficial repos for artix
a list from [arch](https://wiki.archlinux.org/title/User_repo#Signed) and [artix](https://wiki.artixlinux.org/Main/UnofficialUserRepositories)

### autostart on either X11 or Wayland without a display manager
edit in `.bash_profile` from your home directory

find a line below and replace it from `startx` to `river` or vice-versa

```
# autostart your WM here
if [ "$(tty)" = "/dev/tty1" ]; then
startx &>/dev/null
fi
```

## quick links
- Native Wayland App Lists: [1,](https://wearewaylandnow.com/) [2,](https://github.com/rcalixte/awesome-wayland) [3,](https://wiki.gentoo.org/wiki/List_of_software_for_Wayland) [4](https://codeberg.org/river/wiki/src/branch/master/pages/Recommended-Software.md)
- [Are We Sixel Yet?](https://www.arewesixelyet.com/)
- [gruvbox-wallpapers](https://github.com/AngelJumbo/gruvbox-wallpapers)
- [Laptop Optimizations for Linux](https://gist.github.com/LarryIsBetter/218fda4358565c431ba0e831665af3d1)
- [madand's runit-services](https://github.com/madand/runit-services)
- [ncmpcpp cheat sheet](https://pkgbuild.com/~jelle/ncmpcpp/)
- [nvidia-vaapi-driver](https://github.com/elFarto/nvidia-vaapi-driver)
