[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH=$PATH:$HOME/stuffs/.scripts:$HOME/.local/bin
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export MAIL="thunderbird"

# vaapi and vdpau enviromental variables
# export LIBVA_DRIVER_NAME=i965
# export VDPAU_DRIVER=va_gl

# nvidia-vaapi-driver enviromental variables
# export NVD_LOG=0
# export NVD_BACKEND=direct

pipewire &
pipewire-pulse &
wireplumber &

if [[ "$(tty)" = "/dev/tty1" ]]; then
        startx &>/dev/null
fi
