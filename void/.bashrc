[[ $- != *i* ]] && return

PS1='\[\e[1;31m\][\[\e[1;33m\]\u\[\e[1;32m\]@\[\e[1;34m\]\h \[\e[1;35m\]\w\[\e[1;31m\]]\[\e[1;00m\]\$\[\e[0;00m\] '

# shows search instead of freezing your terminal by doing ctrl + s
stty -ixon

# zsh-autocomplete like
shopt -s autocd
shopt -s direxpand

# unlimited history
HISTSIZE=10000000
HISTFILESIZE=10000000

# colored outputs
alias ls="ls -hN --color=auto --group-directories-first"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ccat="highlight --out-format=ansi"
alias ip="ip -color=auto"

# verbose outputs
alias cp="cp -riv"
alias mv="mv -iv"
alias rm="rm -Irv"
alias bc="bc -ql"
alias rsync="rsync -Pvrlu"
alias mkdir="mkdir -pv"
alias ffmpeg="ffmpeg -hide_banner"

# shortcuts/abbreviations
alias ff='fastfetch --logo void2_small --logo-color-2 37 --logo-padding-left 2 --logo-padding-right 2 --logo-padding-top 1'
alias xr='doas xbps-remove -ROov'
alias xi='doas xbps-install -Suv'
alias xq='xbps-query -Rs'
alias xf='xbps-query -f'
alias xc='doas rm -rf /var/cache/xbps/*'
alias lf='lfub'
alias fstrim='doas fstrim -av'
alias yt-dlp='yt-dlp -S res:1080 -S vcodec:h264 --restrict-filenames -o "%(title)s.%(ext)s" --sponsorblock-remove all --audio-format mp3'
alias reboot='loginctl reboot'
alias poweroff='loginctl poweroff'
alias reload='loginctl reload'
alias suspend='loginctl suspend'
alias hibernate='loginctl hibernate'
alias hybrid-sleep='loginctl hybrid-sleep'
alias suspend-then-hibernate='loginctl suspend-then-hibernate'
alias bctl='bluetoothctl'
alias sudo='doas'
alias update-mdocml='doas makewhatis -a'
alias update-grub='doas update-grub'
alias update-rules='cd /etc/ananicy.d/ && sudo git pull && cd'

# xbps-src
alias xib='cd $HOME/stuffs/git/xbps-src && doas xbps-install --repository hostdir/binpkgs && cd'
alias xbps-src='$HOME/stuffs/git/xbps-src/xbps-src'
alias xbps-src-update='cd $HOME/stuffs/git/xbps-src && git pull && cd'
