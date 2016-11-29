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

( while pgrep ntpdate; do sleep 0.5; done; sleep 4; leechcraft ) &

if [ $(which telegram-desktop) ]
then
    pgrep telegram-desktop || telegram-desktop &
fi

exec xmonad
