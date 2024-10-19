[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH=$PATH:$HOME/stuffs/.scripts:$HOME/.local/bin
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export MAIL="thunderbird"

pipewire &

if [[ "$(tty)" = "/dev/tty1" ]]; then
	    startx &>/dev/null
fi
