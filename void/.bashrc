[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\e[1;31m\][\[\e[1;33m\]\u\[\e[1;32m\]@\[\e[1;34m\]\h \[\e[1;35m\]\w\[\e[1;31m\]]\[\e[1;00m\]\$\[\e[0;00m\] '

alias lf="ranger"
alias xr="doas xbps-remove -ROoFfv"
alias xi="doas xbps-install -Suv"
alias xq="xbps-query -Rs"
alias xf="xbps-query -f"
alias yt-dlp="yt-dlp -S res:1080 -S vcodec:h264"
alias reboot="loginctl reboot"
alias poweroff="loginctl poweroff"
alias bctl="bluetoothctl"
alias sudo="doas"

ufetch
