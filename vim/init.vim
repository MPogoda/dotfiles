if has ('vim_starting')
    if has ('nvim')
        let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1

        set runtimepath+=~/.config/nvim/bundle/neobundle.vim/
    else
        set nocompatible

        set runtimepath+=~/.vim/bundle/neobundle.vim/
    endif

    let mapleader = " "
endif

if has ('nvim')
    call neobundle#begin(expand('~/.config/nvim/bundle/'))
else
    call neobundle#begin(expand('~/.vim/bundle/'))
endif

runtime! bundles.vim

call neobundle#end()

NeoBundleCheck

" delegate configuration to files in config/
runtime! config/**/*.vim
