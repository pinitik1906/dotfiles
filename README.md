# content

- [programs i use](#programs-i-use)
- [faq](#faq)
  - [custom gtk themes in X11/Wayland](#custom-gtk-themes-in-x11wayland)
  - [weird yellow/red color on my monitor](#weird-yellowred-color-on-my-monitor)
  - [image previews in either X11/Wayland](#image-previews-in-either-x11wayland)
  - [proprietary NVIDIA on Wayland for artix](#proprietary-nvidia-on-wayland-for-artix)
  - [unofficial repos for artix](#unofficial-repos-for-artix)
  - [autostart on either X11 or Wayland without a display manager](#autostart-on-either-x11-or-wayland-without-a-display-manager)
- [quick links](#quick-links)

## programs i use

- [`dwm`](https://github.com/pinitik1906/dwm) / [`dwl`](https://github.com/pinitik1906/dwl)
- [`st`](https://github.com/pinitik1906/st) / `foot`
- `rofi` / `tofi`
- [`slstatus`](https://github.com/pinitik1906/slstatus)
- `zsh`
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

## install
to get my dotfiles, type

```
git clone --depth 1 https://github.com/pinitik1906/dotfiles.git $HOME/stuffs/git/dotfiles
```

## update
to update my dotfiles (either check it weekly or monthly), type

```
cd $HOME/stuffs/git/dotfiles && git pull
```

## faq

### custom gtk themes in X11/Wayland
install and use `lxappearance` if you are in X11, or `nwg-look` in Wayland

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

### image previews in either X11/Wayland
go to `$HOME/.config/ueberzugpp/config.json` and change `x11` to `sixel` or vice-versa

```
{
  "layer": {
    "silent": true,
    "use-escape-codes": false,
    "no-stdin": false,
    "output": "x11"
  }
}
```

### proprietary NVIDIA on Wayland for artix
this is needed to make wayland compositors to function properly, referencing this [website](https://linuxiac.com/nvidia-with-wayland-on-arch-setup-guide/) but friendly since I did some preconfiguration. (i will choose neovim for this tutorial)

uncomment inside my `.zprofile` in `nvidia tweaks` and `direct backend for nvidia` by removing a hashtag and rename in `vaapi & vdpau env` from both `i965,va_gl` to `nvidia`, so it will look like this

```
nvim $HOME/.zprofile
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
sudo mkinitcpio -P && sudo grub-mkconfig -o /boot/grub/grub.cfg
```

finally, reboot your pc and check if NVIDIA DRM were set correctly

```
sudo cat /sys/module/nvidia_drm/parameters/modeset
```

### unofficial repos for artix
a list from [arch](https://wiki.archlinux.org/title/User_repo#Signed) and [artix](https://wiki.artixlinux.org/Main/UnofficialUserRepositories)

### autostart on either X11 or Wayland without a display manager
edit in `.zprofile` from your home directory

find a line below and replace it from `startx` to `startw` or vice-versa

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
