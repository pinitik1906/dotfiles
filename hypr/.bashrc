#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1=' \[\033[36m\]\W/\[\033[33m\] > '

fastfetch -l arch_small --logo-color-1 33
