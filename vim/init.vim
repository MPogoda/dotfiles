if has ('vim_starting')
    set nocompatible

    let mapleader = " "
    let maplocalleader = "_"
endif

if has ('nvim')
    if empty(glob('~/.config/nvim/autoload/plug.vim'))
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif
    call plug#begin(expand('~/.config/nvim/bundle/'))
else
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif
    call plug#begin(expand('~/.vim/bundle/'))
endif

runtime! bundles.vim

call plug#end()

" delegate configuration to files in config/
runtime! config/**/*.vim
