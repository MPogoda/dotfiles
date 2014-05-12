# vim: ft=sh
xsetroot -cursor_name left_ptr
[ -f ~/.wallpaper ] && feh --bg-tile ~/.wallpaper || xsetroot -gray
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

setxkbmap -layout 'us,ru,us(colemak)'
setxkbmap -option grp:rctrl_rshift_toggle
setxkbmap -option caps:backspace
setxkbmap -option compose:ralt

if [ $(which kbdd) ]
then
    pgrep kbdd || kbdd
fi

[ -f .gnupg/gpg-agent.env ] && . .gnupg/gpg-agent.env
GPG_AGENT=$( echo ${GPG_AGENT_INFO:-0} | cut -d: -f1 )

if [ -e $GPG_AGENT ]
then
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
    export SSH_AGENT_PID
else
    eval $(gpg-agent --write-env-file ${HOME}/.gnupg/gpg-agent.env --enable-ssh-support --daemon )
fi

compton --vsync opengl --use-ewmh-active-win --glx-use-gpushader4 &

exec xmonad
