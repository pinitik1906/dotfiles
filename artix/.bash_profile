[[ -f ~/.bashrc ]] && . ~/.bashrc

# general tweaks & fixes
export PATH=$PATH:$HOME/stuffs/.scripts:$HOME/.local/bin
export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER='nvim +Man!'
export TERMINAL='urxvt'
export BROWSER='firefox'
export MAIL='thunderbird'
export GTK_THEME=Adwaita:dark

# wayland fixes
export GDK_BACKEND='wayland,x11'
export QT_QPA_PLATFORM='wayland;xcb'
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_SCALE_FACTOR_ROUNDING_POLICY=RoundPreferFloor
export CLUTTER_BACKEND=wayland
export SDL_VIDEODRIVER='wayland,x11'
export XDG_SESSION_TYPE=wayland
export ELM_DISPLAY=wl

# nvidia tweaks
#export __EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/10_nvidia.json
#export GBM_BACKEND=nvidia-drm
#export __GLX_VENDOR_LIBRARY_NAME=nvidia

# firefox tweaks
export MOZ_USE_XINPUT2=1
export MOZ_ENABLE_WAYLAND=1
export MOZ_DISABLE_RDD_SANDBOX=1

# vaapi & vdpau env
#export LIBVA_DRIVER_NAME=i965
#export VDPAU_DRIVER=va_gl

# direct backend for nvidia
#export NVD_LOG=0
#export NVD_BACKEND=direct

# screenshare support for wayland
export XDG_CURRENT_DESKTOP=river

# autostart your WM here
if [[ "$(tty)" = "/dev/tty1" ]]; then
river &>/dev/null
fi
