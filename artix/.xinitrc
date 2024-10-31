pgrep -x sxhkd > /dev/null || sxhkd &
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
redshift -P -x -r -O 2300 &
dunst &
xrdb -merge ~/.Xresources &

exec bspwm
