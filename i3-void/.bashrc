#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\e[1;31m\][\[\e[1;33m\]\u\[\e[1;32m\]@\[\e[1;34m\]\h \[\e[1;35m\]\w\[\e[1;31m\]]\[\e[1;00m\]\$\[\e[0;00m\] '

alias lf="ranger"
alias xir="sudo xbps-remove -Oofv"
alias xii="sudo xbps-install -Suv"
alias xiq="xbps-query -Rs"
alias xif="xbps-query -f"
alias yt-dlp="yt-dlp -S res:1080"
alias reboot="sudo reboot"
alias poweroff="sudo poweroff"
alias rm="rm -rfv"
alias bctl="bluetoothctl"

fastfetch --logo-color-2 37 --logo-padding-left 3 --logo-padding-top 1
