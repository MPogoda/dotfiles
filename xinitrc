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

SSH_AUTH_SOCK=$(gpg-connect-agent 'getinfo ssh_socket_name' /bye | grep '^D' | cut -d' ' -f2)
[ -S "$SSH_AUTH_SOCK" ] && export SSH_AUTH_SOCK

# xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
# xrandr --addmode VBOX0 "1920x1080_60.00"
# xrandr --size 1920x1080
# xrandr --dpi 82x82

VBoxClient-all

( sleep 1 && leechcraft-qt5 ) &

exec xmonad
