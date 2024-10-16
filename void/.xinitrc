pgrep -x sxhkd > /dev/null || sxhkd &
lxpolkit &
redshift -P -x -r -O 2300 &
xrdb ~/.Xresources &
dunst &

exec bspwm
