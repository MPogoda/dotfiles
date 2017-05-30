if has ('vim_starting')
    if has ('nvim')
        let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    else
        set nocompatible
    endif

    let mapleader = " "
endif

set rtp^=/usr/share/vim/vimfiles/

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
