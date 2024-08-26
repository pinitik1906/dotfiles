[[ -f ~/.bashrc ]] && . ~/.bashrc

export EDITOR="vim"
export TERMINAL="alacritty"
export BROWSER="firefox"

if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep i3 || startx
fi
