#!/bin/sh
# vim: ft=sh

xsetroot -cursor_name left_ptr
[ -f ~/.wallpaper ] && feh --bg-tile ~/.wallpaper || xsetroot -gray
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

if [ $(which kbdd) ]
then
    pgrep kbdd || kbdd
fi

if [ $(which cantata) ]
then
    (sleep 2; cantata) &
fi
redshift -l 50.449551:30.450408 &

exec xmonad
