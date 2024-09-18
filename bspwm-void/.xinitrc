pgrep -x sxhkd > /dev/null || sxhkd &
xrdb ~/.Xresources &
pipewire &
dunst &

exec bspwm
