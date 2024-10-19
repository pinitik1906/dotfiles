## install
to get my dotfiles, type

```
git clone --depth 1 https://github.com/pinitik1906/dotfiles.git ~/git/dotfiles
```

## update
to update my dotfiles (either check it weekly or monthly), type

```
cd ~/git/dotfiles && git fetch && git pull
```

## my personal-kernel-parameters for *intel*
for `grub` in /etc/default/grub
```
GRUB_CMDLINE_LINUX_DEFAULT="quiet loglevel=0 console=tty12 udev.log_level=0 nmi_watchdog=0 intel_iommu=off clocksource=tsc tsc=reliable preempt=full msr.allow_writes=on i915.enable_fbc=1 i915.enable_guc=3 i915.fastboot=1 i915.enable_dc=4 i915.enable_psr=2"
```
then do in ***artix***,
```
grub-mkconfig -o /boot/grub/grub.cfg
```
or in ***void***
```
update-grub
```

for `refind` in /boot/refind_linux.conf (ignore the root=*)
```
"Boot with standard options"  "root=UUID=d13a76e9-3ed4-41d9-8ddd-1e31c40b91b4 rw quiet loglevel=0 console=tty12 udev.log_level=0 nmi_watchdog=0 intel_iommu=off clocksource=tsc tsc=reliable preempt=full msr.allow_writes=on i915.enable_fbc=1 i915.enable_guc=3 i915.fastboot=1 i915.enable_dc=4 i915.enable_psr=2"
```

## faq

#### enabling-repos for artix
a [guide](https://wiki.artixlinux.org/Main/Repositories) by the artix linux team (NEEDED FROM MY ARTIX INSTALL SCRIPT)

#### autostart-hyprland-without-display-manager
edit in `.bash_profile` from your home directory

find a line below and replace it from `startx` to `hyprland`
```
if [[ "$(tty)" = "/dev/tty1" ]]; then
        startx &>/dev/null
fi
```

#### why-tier-1-mirror for void?
taken from the [void-handbook](https://xmirror.voidlinux.org) 

"The **tier 1 mirrors** sync directly from the build servers and will always have the latest packages available. While **tier 2 mirrors** are not managed by Void and do not have any guarantees of freshness or completeness of packages, nor are they required to sync every available architecture or sub-repository."

#### customizing-gtk-themes and dark-mode
to use custom themes for X11 and Wayland, install and open `nwg-look` to change themes

to make it dark mode, change "Color Scheme" to "Prefer dark"

## quick-links (huge thanks <3)
- [Laptop Optimizations for Linux](https://gist.github.com/LarryIsBetter/218fda4358565c431ba0e831665af3d1)
- [madand's runit-services](https://github.com/madand/runit-services)
- [voidhandbook-networkmanager](https://docs.voidlinux.org/config/network/networkmanager.html#starting-networkmanager)
- [voidhandbook-kernel](https://docs.voidlinux.org/config/kernel.html#switching-to-another-kernel-series)
- [voidhandbook-fonts](https://docs.voidlinux.org/config/graphical-session/fonts.html)
- [voidhyprland-repo](https://github.com/Makrennel/hyprland-void)
- [void-optimizations](https://gist.github.com/themagicalmammal/e443d3c5440d566f8206e5b957ab1493)
- [void-src](https://github.com/void-linux/void-packages)
- [void-wallpapers](https://osowoso.github.io/Void-Wallpapers/)
