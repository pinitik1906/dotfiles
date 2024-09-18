[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH=$PATH:$HOME/stuffs/.scripts:$HOME/.local/bin
export EDITOR="nvim"
export TERMINAL="urxvt"
export BROWSER="firefox"
export MAIL="thunderbird"

if [[ "$(tty)" = "/dev/tty1" ]]; then
            startx
fi
