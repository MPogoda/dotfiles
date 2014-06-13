#!/bin/sh

function install_file()
{
# $1 - name in repo
# $2 - name in ~

  echo "Install ${1} to ${2}? (y/n)"
  read answer
  if [ "$answer" = "y" ]
  then
    [ -e "$2" ] && echo "Creating ${2}.bak" && mv -v -- ${2} ${2}.bak
    ln -sfv ${BASE_PATH}/$1 $2
    return 0
  else
    return 1
  fi
}

PATH_TO_INSTALL_SH=$0
BASE_PATH=${PATH_TO_INSTALL_SH%/*}
echo "Installing dotfiles from ${BASE_PATH}..."

install_file "gitconfig" ".gitconfig"
install_file "tmux.conf" ".tmux.conf"
install_file "tmux.sh" "tmux.sh"
install_file "xinitrc" ".xinitrc"
install_file "xmobarrc" ".xmobarrc"
mkdir -pv .xmonad
install_file "xmonad.hs" ".xmonad/xmonad.hs" ".."
install_file "Xresources" ".Xresources"
install_file "Xresources.theme" ".Xresources.theme"

install_file "zsh" ".zsh"
install_file "zshrc" ".zshrc"

install_file "vim" ".vim"
install_file "vim/vimrc" ".vimrc" && git clone --depth 1 https://github.com/Shougo/neobundle.vim $BASE_PATH/vim/bundle/neobundle.vim && vim +NeoBundleInstall +qall

