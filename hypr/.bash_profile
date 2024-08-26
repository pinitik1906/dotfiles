[[ -f ~/.bashrc ]] && . ~/.bashrc

export EDITOR="neovim"
export TERMINAL="alacritty"
export BROWSER="firefox"

if [[ "$(tty)" = "/dev/tty1" ]]; then
            Hyprland
fi
