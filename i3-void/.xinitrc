pgrep -x sxhkd > /dev/null || sxhkd &
exec xrdb ~/.Xresources &
exec pipewire &
exec dunst &

exec bspwm
