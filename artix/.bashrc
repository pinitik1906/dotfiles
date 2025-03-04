[[ $- != *i* ]] && return

PS1='\[\e[1;31m\][\[\e[1;33m\]\u\[\e[1;32m\]@\[\e[1;34m\]\h \[\e[1;35m\]\w\[\e[1;31m\]]\[\e[1;00m\]\$\[\e[0;00m\] '

# colored outputs
alias ls="ls -hN --color=auto --group-directories-first"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ccat="highlight --out-format=ansi"
alias ip="ip -color=auto"

# verbose outputs
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -Iv"
alias bc="bc -ql"
alias rsync="rsync -Pvrlu"
alias mkdir="mkdir -pv"
alias yt="yt-dlp --embed-metadata -i"
alias ffmpeg="ffmpeg -hide_banner"

# shortcuts/abbreviations
alias ff='fastfetch --logo artix_small --logo-padding-left 2 --logo-padding-right 2 --logo-padding-top 1'
alias xr='paru -Qqtd | paru -Rns -'
alias xi='paru -Syu --needed'
alias xq='paru'
alias xf='paru -Ql'
alias xc='paru -Scc'
alias yt-dlp='yt-dlp -S res:1080 -S vcodec:h264 --audio-format mp3 --restrict-filenames -o "%(title)s.%(ext)s" --sponsorblock-remove all'
alias reboot='loginctl reboot'
alias poweroff='loginctl poweroff'
alias reload='loginctl reload'
alias suspend='loginctl suspend'
alias hibernate='loginctl hibernate'
alias hybrid-sleep='loginctl hybrid-sleep'
alias suspend-then-hibernate='loginctl suspend-then-hibernate'
alias bctl='bluetoothctl'
alias sudo='doas'
alias update-mandoc='doas makewhatis -a'
alias update-grub='doas grub-mkconfig -o /boot/grub/grub.cfg'
alias update-rules='cd /etc/ananicy.d/ && sudo git pull && cd'
