#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\e[1;31m\][\[\e[1;33m\]\u\[\e[1;32m\]@\[\e[1;34m\]\h \[\e[1;35m\]\w\[\e[1;31m\]]\[\e[1;00m\]\$\[\e[0;00m\] '

alias lf="ranger"
alias pr="paru -Rnsudd $(paru -Qqtd)"
alias pi="paru -Syu --needed"
alias pq="paru"
alias pf="paru -Ql"
alias pc="paru -Sc"
alias pcc="paru -Scc"
alias yt-dlp="yt-dlp -S res:1080"
alias reboot="loginctl reboot"
alias poweroff="loginctl poweroff"
alias bctl="bluetoothctl"
alias sudo="doas"

fastfetch --logo ~/.config/fastfetch/artix2_small-fix.txt --logo-padding-left 2 --logo-padding-right 2 --logo-padding-top 1
