[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH=$PATH:$HOME/stuffs/.scripts:$HOME/.local/bin
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="foot"
export BROWSER="firefox"
export MAIL="thunderbird"
export LIBVA_DRIVER_NAME="i965"

/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
/usr/bin/wireplumber &

if [[ "$(tty)" = "/dev/tty1" ]]; then
            Hyprland
fi
