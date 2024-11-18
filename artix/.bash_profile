[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH=$PATH:$HOME/stuffs/.scripts:$HOME/.local/bin
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="urxvt"
export BROWSER="firefox"
export MAIL="thunderbird"

# firefox tweaks
export MOZ_USE_XINPUT2=1
export MOZ_ENABLE_WAYLAND=1

# vaapi & vdpau env
#export LIBVA_DRIVER_NAME=i965
#export VDPAU_DRIVER=va_gl

#export NVD_LOG=0
#export NVD_BACKEND=direct

pipewire &
pipewire-pulse &
wireplumber &

if [[ "$(tty)" = "/dev/tty1" ]]; then
startx &>/dev/null
fi
