[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH=$PATH:$HOME/stuffs/.scripts:$HOME/.local/bin
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="urxvt"
export BROWSER="firefox"
export MAIL="thunderbird"

#export LIBVA_DRIVER_NAME=i965
#export VDPAU_DRIVER=va_gl

#export NVD_LOG=0
#export NVD_BACKEND=direct

pipewire &

if [[ "$(tty)" = "/dev/tty1" ]]; then
river &>/dev/null
fi
