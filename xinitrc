xsetroot -cursor_name left_ptr
[ -f ~/.wallpaper ] && feh --bg-tile ~/.wallpaper || xsetroot -gray
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
[ -f ~/.Xresources.theme ] && xrdb -merge ~/.Xresources.theme
setxkbmap -layout us,ru -option grp:caps_toggle

if [ $(which kbdd) ]
then
  pgrep kbdd || kbdd
fi

if [ $(which urxvtd) ]
then
  pgrep urxvtd || urxvtd --opendisplay --fork
fi

if [ $(which stalonetray) ]
  pgrep stalonetray || stalonetray&
fi

eval $(gpg-agent --write-env-file ${HOME}/.gnupg/gpg-agent.env --enable-ssh-support --daemon )

exec xmonad
