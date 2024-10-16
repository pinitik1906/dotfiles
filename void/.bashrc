#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\e[1;31m\][\[\e[1;33m\]\u\[\e[1;32m\]@\[\e[1;34m\]\h \[\e[1;35m\]\w\[\e[1;31m\]]\[\e[1;00m\]\$\[\e[0;00m\] '

alias lf="ranger"
alias xr="doas xbps-remove -ROoFfv"
alias xi="doas xbps-install -Suv"
alias xq="xbps-query -Rs"
alias xf="xbps-query -f"
alias yt-dlp="yt-dlp -S res:1080"
alias reboot="loginctl reboot"
alias poweroff="loginctl poweroff"
alias bctl="bluetoothctl"
alias sudo="doas"

fastfetch --logo void2_small --logo-color-2 37 --logo-padding-left 2 --logo-padding-right 2 --logo-padding-top 1