[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH=$PATH:$HOME/stuffs/.scripts:$HOME/.local/bin
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="urxvt"
export BROWSER="firefox"
export MAIL="thunderbird"
export LIBVA_DRIVER_NAME="i965"

pipewire &

if [[ "$(tty)" = "/dev/tty1" ]]; then
	exec Hyprland &>/dev/null
fi
