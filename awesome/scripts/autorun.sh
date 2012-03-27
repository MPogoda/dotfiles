#!/bin/sh

wmname LG3D
setxkbmap -layout us,ru -option grp:caps_toggle,grp_led:caps,grp_led:scroll,grp_led:num -model pc105
pgrep -x urxvtd >/dev/null || urxvtd --opendisplay --quiet --fork
