[[ -f ~/.bashrc ]] && . ~/.bashrc

export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"

if [[ "$(tty)" = "/dev/tty1" ]]; then
            Hyprland
fi