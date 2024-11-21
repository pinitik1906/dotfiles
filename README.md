## install
to get my dotfiles, type

```
git clone --depth 1 https://github.com/pinitik1906/dotfiles.git ~/git/dotfiles
```

## update
to update my dotfiles (either check it weekly or monthly), type

```
cd ~/git/dotfiles && git pull
```

## my personal-kernel-parameters for *intel*
for `grub` in /etc/default/grub, copy my kernel parameters
```
GRUB_CMDLINE_LINUX_DEFAULT="quiet loglevel=0 console=tty12 udev.log_level=0 nmi_watchdog=0 nowatchdog modprobe.blacklist=iTCO_wdt modprobe.blacklist=sp5100_tco intel_iommu=off clocksource=tsc tsc=reliable preempt=full msr.allow_writes=on i915.enable_fbc=1 i915.enable_guc=3 i915.fastboot=1 i915.enable_dc=4 i915.enable_psr=2"
```
then do in ***artix***,
```
grub-mkconfig -o /boot/grub/grub.cfg
```
or in ***void***
```
update-grub
```

## faq

#### unofficial-repos for artix
a list from [arch](https://wiki.archlinux.org/title/Unofficial.user.repositories#Signed) and [artix](https://wiki.artixlinux.org/Main/UnofficialUserRepositories)

#### autostart-river-without-display-manager
edit in `.bash_profile` from your home directory

find a line below and replace it from `startx` to `river`
```
if [[ "$(tty)" = "/dev/tty1" ]]; then
        startx &>/dev/null
fi
```

#### why-tier-1-mirror for void?
taken from the [void-xmirror](https://xmirror.voidlinux.org) 

"The **tier 1 mirrors** sync directly from the build servers and will always have the latest packages available. While **tier 2 mirrors** are not managed by Void and do not have any guarantees of freshness or completeness of packages, nor are they required to sync every available architecture or sub-repository."

#### customizing-gtk-themes and dark-mode
to use custom themes for X11 and Wayland, install and open `nwg-look` to change themes

to make it dark mode, change "Color Scheme" to "Prefer dark"

## quick-links (huge thanks <3)
- [Laptop Optimizations for Linux](https://gist.github.com/LarryIsBetter/218fda4358565c431ba0e831665af3d1)
- [madand's runit-services](https://github.com/madand/runit-services)
- [void-handbook](https://docs.voidlinux.org)
- [void-optimizations](https://gist.github.com/themagicalmammal/e443d3c5440d566f8206e5b957ab1493)
- [void-src](https://github.com/void-linux/void-packages)
- [void-wallpapers](https://osowoso.github.io/Void-Wallpapers/)
