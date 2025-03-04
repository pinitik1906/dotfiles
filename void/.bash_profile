[[ -f ~/.bashrc ]] && . ~/.bashrc

# global enviromental variables

# path to ~/.local/bin to execute scripts inside
export PATH=$PATH:$HOME/.local/bin

# default applications
export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER='nvim +Man!'
export TERMINAL='urxvt'
export TERMINAL_PROG='urxvt'
export BROWSER='librewolf'
export MAIL='thunderbird'

# xdg-base-directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# spring $HOME cleaning!
export BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME/bash/bash_completion"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export W3M_DIR="$XDG_DATA_HOME/w3m"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch/notmuch-config"
export INPUTRC="$XDG_CONFIG_HOME/shell/inputrc"
export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
export XSERVERRC="$XDG_CONFIG_HOME/x11/xserverrc"
export XAUTHORITY="$XDG_RUNTIME_DIR/xauthority"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export KODI_DATA="$XDG_DATA_HOME/kodi"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
export UNISON="$XDG_DATA_HOME/unison"
export HISTFILE="$XDG_DATA_HOME/history"
export LESSHISTFILE="-"
export MBSYNCRC="$XDG_CONFIG_HOME/mbsync/config"
export ELECTRUMDIR="$XDG_DATA_HOME/electrum"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"
export RXVT_SOCKET="$XDG_RUNTIME_DIR/urxvtd"
export XCOMPOSEFILE="$XDG_CONFIG_HOME/x11/xcompose"
export XCOMPOSECACHE="$XDG_CACHE_HOME/x11/xcompose"

# force adwaita dark theme
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

# autostart for audio/video
pipewire &

# autostart your WM here
if [[ "$(tty)" = "/dev/tty1" ]]; then
startx &>/dev/null
fi
