if has ('vim_starting')
    set nocompatible

    if has ('nvim')
        set runtimepath+=~/.config/nvim/bundle/neobundle.vim/
    else
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
