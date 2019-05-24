#!/bin/sh

# vim: ft=sh
xsetroot -cursor_name left_ptr
[ -f ~/.wallpaper ] && feh --bg-tile ~/.wallpaper || xsetroot -gray
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

setxkbmap -layout 'us(colemak),ru'
setxkbmap -option grp:rctrl_rshift_toggle
setxkbmap -option caps:backspace
setxkbmap -option compose:ralt

if [ $(which kbdd) ]
then
    pgrep kbdd || kbdd
fi

compton &

leechcraft &
cantata &
redshift -l 50.449551:30.450408 &

( sleep 3; xrandr --output HDMI-0 --mode 1920x1080 --below DP-2 ) &
exec xmonad
