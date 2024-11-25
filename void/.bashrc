[[ $- != *i* ]] && return

alias cat="bat -n"
alias less="bat --paging always"
alias ls="eza -A"
alias grep="rg --no-ignore --hidden"
PS1='\[\e[1;31m\][\[\e[1;33m\]\u\[\e[1;32m\]@\[\e[1;34m\]\h \[\e[1;35m\]\w\[\e[1;31m\]]\[\e[1;00m\]\$\[\e[0;00m\] '

alias lf="ranger"
alias xr="doas xbps-remove -ROoFfv"
alias xi="doas xbps-install -Suv"
alias xq="xbps-query -Rs"
alias xf="xbps-query -f"
alias yt-dlp="yt-dlp -S res:1080 -S vcodec:h264 --audio-format mp3"
alias reboot="loginctl reboot"
alias poweroff="loginctl poweroff"
alias bctl="bluetoothctl"
alias sudo="doas"
alias update-rules="cd /etc/ananicy.d/ && sudo git pull && cd"

fastfetch --logo-color-2 37 --logo-padding-left 2 --logo-padding-right 2 --logo-padding-top 1
