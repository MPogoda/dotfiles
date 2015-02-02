if has ('vim_starting')
    set nocompatible

    set runtimepath+=~/.vim/bundle/neobundle.vim/

    let mapleader = " "
endif

call neobundle#begin(expand('~/.vim/bundle/'))

runtime! bundles.vim

call neobundle#end()

NeoBundleCheck

" delegate configuration to files in config/
runtime! config/**/*.vim
