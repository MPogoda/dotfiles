if has ('vim_starting')
    if has ('nvim')
        let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1

        set runtimepath+=~/.config/nvim/bundle/Vundle.vim
    else
        set nocompatible

        set runtimepath+=~/.vim/bundle/Vundle.vim
    endif

    let mapleader = " "
endif

if has ('nvim')
    call vundle#begin(expand('~/.config/nvim/bundle/'))
else
    call vundle#begin(expand('~/.vim/bundle/'))
endif

runtime! bundles.vim

call vundle#end()

" delegate configuration to files in config/
runtime! config/**/*.vim
