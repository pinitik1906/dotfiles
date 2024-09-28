pgrep -x sxhkd > /dev/null || sxhkd &
/usr/libexec/polkit-gnome-authentication-agent-1 &
redshift -P -x -r -O 2300 &
xrdb ~/.Xresources &
dunst &

exec bspwm
