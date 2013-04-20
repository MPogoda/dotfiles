xsetroot -cursor_name left_ptr
[ -f ~/.wallpaper ] && feh --bg-tile ~/.wallpaper || xsetroot -gray
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
setxkbmap -layout us,ru -option grp:caps_toggle

if [ $(which kbdd) ]
then
  pgrep kbdd || kbdd
fi

if [ $(which stalonetray) ]
then
  pgrep stalonetray || stalonetray&
fi

eval $(gpg-agent --write-env-file ${HOME}/.gnupg/gpg-agent.env --enable-ssh-support --daemon )

exec xmonad
