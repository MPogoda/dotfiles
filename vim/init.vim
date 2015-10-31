if has ('vim_starting')
    set nocompatible

    if has ('nvim')
        set runtimepath+=~/.config/nvim/bundle/neobundle.vim/
    else
        set runtimepath+=~/.vim/bundle/neobundle.vim/
    endif

    if has ('nvim')
        let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
        if !exists ('$TMUX')
            let $NVIM_TUI_ENABLE_TRUE_COLOR=1
        endif
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
