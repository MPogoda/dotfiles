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

SSH_AUTH_SOCK=$(gpg-connect-agent 'getinfo ssh_socket_name' /bye | grep '^D' | cut -d' ' -f2)
[ -S "$SSH_AUTH_SOCK" ] && export SSH_AUTH_SOCK

compton &

exec xmonad
