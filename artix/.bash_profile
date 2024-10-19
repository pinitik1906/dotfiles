[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH=$PATH:$HOME/stuffs/.scripts:$HOME/.local/bin
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export MAIL="thunderbird"

# intel optimization
# export LIBVA_DRIVER_NAME=i965
# export VDPAU_DRIVER=va_gl

pipewire &
pipewire-pulse &
wireplumber &

if [[ "$(tty)" = "/dev/tty1" ]]; then
        startx &>/dev/null
fi
