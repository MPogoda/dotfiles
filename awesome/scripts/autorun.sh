#!/bin/sh

wmname LG3D
setxkbmap -layout us,ru -option grp:caps_toggle -model pc86
pgrep -x urxvtd >/dev/null || urxvtd --opendisplay --quiet --fork
pgrep -x kbdd >/dev/null || kbdd
