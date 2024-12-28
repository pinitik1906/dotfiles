### install
to get my dotfiles, type

```
git clone --depth 1 https://github.com/pinitik1906/dotfiles.git ~/git/dotfiles
```

### update
to update my dotfiles (either check it weekly or monthly), type

```
cd ~/git/dotfiles && git pull
```

### my kernel parameters for intel
for `grub` in /etc/default/grub, copy my kernel parameters

```
GRUB_CMDLINE_LINUX_DEFAULT="quiet loglevel=0 console=tty12 udev.log_level=0 nmi_watchdog=0 nowatchdog modprobe.blacklist=iTCO_wdt modprobe.blacklist=sp5100_tco intel_iommu=igfx_off clocksource=tsc tsc=reliable preempt=full msr.allow_writes=on i915.enable_fbc=1 i915.enable_guc=3 i915.fastboot=1 i915.enable_dc=4 i915.enable_psr=2 cryptomgr.notests initcall_debug kvm-intel.nested=1 no_timer_check noreplace-smp page_alloc.shuffle=1 rcupdate.rcu_expedited=1 mitigations=off"
```

then do,
```
sudo update-grub
```

### my initramfs optimization for void
**DANGEROUS SETTINGS**

for `dracut` /etc/dracut.conf.d/*anyname*.conf, copy my *anyname*.conf

```
hostonly="yes"
hostonly_cmdline="no"
use_fstab="yes"
compress="cat"
omit_dracutmodules+=" mulitpath lvm watchdog watchdog-modules btrfs numlock dash crypt crypt-gpg convertfs caps il8n dmraid mdraid qemu dmsquash-live dmsquash-live-ntfs dmsquash-live-autooverlay img-lib biosdevname terminfo fstab-sys lunmask ecryptfs virtfs virtiofs drm nvmf dm debug nvdimm pollcdrom syslog busybox pcmcia ppcmac warpclock lvmthinpool-monitor hwdb fips fips-crypto-policies masterkey overlayfs dracut-systemd systemd systemd-network-management systemd-networkd integrity kernel-modules-extra "
kernel_cmdline="rd.luks=0 rd.lvm=0 rd.md=0 rd.dm=0"
nofscks="yes"
do_strip="yes"
aggressive_strip="yes"
```

then do,

```
sudo dracut --force && sudo xbps-reconfigure -f *yourkernel*
```

### faq

#### weird yellow/red color on my monitor
it is a program `gammastep` helps your eye with less eye-strains. if you want to remove, use the command below:

**artix**
```
sudo pacman -Rns gammastep
```

**void**
```
sudo xbps-remove -R gammastep
```

#### stutters on wayland (AMD)
add this to your kernel parameters (grub)

```
GRUB_CMDLINE_LINUX_DEFAULT="amdgpu.dcdebugmask=0x400"
```

and do not forget to regenerate it

```
sudo update-grub
```

#### proprietary NVIDIA on Wayland for artix
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
sudo mkinitcpio -P
```

next, go to your kernel parameters (i will choose grub)

```
sudo nvim /etc/default/grub
```

and then copy & paste this

```
GRUB_CMDLINE_LINUX_DEFAULT="nvidia-drm.modeset=1 nvidia_drm.fbdev=1"
```

regenerate it

```
sudo update-grub
```

finally, reboot your pc and check if NVIDIA DRM were set correctly

```
sudo cat /sys/module/nvidia_drm/parameters/modeset
```

#### no output in lf using st (X11)
please change `sixel` to `x11`

ex. inside in `$HOME/.config/ueberzugpp/config.json`
```
{
    "layer": {
        "output": "x11"
    }
}
```

#### unofficial repos for artix
a list from [arch](https://wiki.archlinux.org/title/Unofficial.user.repositories#Signed) and [artix](https://wiki.artixlinux.org/Main/UnofficialUserRepositories)

#### autostart on either X11 or Wayland without a display manager
edit in `.bash_profile` from your home directory

find a line below and replace it from `river` to `startx` or vice-versa

```
# autostart your WM here
if [ "$(tty)" = "/dev/tty1" ]; then
startx &>/dev/null
fi
```

#### why use a tier 1 mirror for void?
taken from the [void-xmirror](https://xmirror.voidlinux.org) 

"The **tier 1 mirrors** sync directly from the build servers and will always have the latest packages available. While **tier 2 mirrors** are not managed by Void and do not have any guarantees of freshness or completeness of packages, nor are they required to sync every available architecture or sub-repository."

### quick links (huge thanks <3)
- Native Wayland App Lists: [1,](https://wearewaylandnow.com/) [2,](https://github.com/rcalixte/awesome-wayland) [3,](https://wiki.gentoo.org/wiki/List_of_software_for_Wayland) [4](https://codeberg.org/river/wiki/src/branch/master/pages/Recommended-Software.md)
- [Are We Sixel Yet?](https://www.arewesixelyet.com/)
- [Laptop Optimizations for Linux](https://gist.github.com/LarryIsBetter/218fda4358565c431ba0e831665af3d1)
- [madand's runit-services](https://github.com/madand/runit-services)
- [nvidia-vaapi-driver](https://github.com/elFarto/nvidia-vaapi-driver)
- [void-handbook](https://docs.voidlinux.org)
- [void-optimizations](https://gist.github.com/themagicalmammal/e443d3c5440d566f8206e5b957ab1493)
- [void-src](https://github.com/void-linux/void-packages)
- [void-wallpapers](https://osowoso.github.io/Void-Wallpapers/)
