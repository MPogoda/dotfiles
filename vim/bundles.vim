" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', { 'build' :
                          \   { 'mac'  : 'make -f make_mac.mak'
                          \   , 'unix' : 'make -f make_unix.mak'
                          \   }
                          \ , 'name' : 'vimproc'
                          \ }
" Unite.vim
NeoBundle 'Shougo/unite.vim', { 'name' : 'unite.vim'
                            \ , 'depends' : 'vimproc'
                            \ }

NeoBundle 'thinca/vim-unite-history'

NeoBundle 'bling/vim-airline'

NeoBundleLazy 'Shougo/neocomplete.vim', { 'autoload' : { 'insert' : 1 } }

NeoBundleLazy 'Rip-Rip/clang_complete', { 'autoload' : { 'filetypes' : ['c', 'cpp'] }
                                      \ , 'name' : 'clang_complete'
                                      \ }

NeoBundleLazy 'docunext/closetag.vim', { 'autoload' : { 'filetypes' : ['html'] }
                                     \ , 'name' : 'closetag'
                                     \ }

" VCS Integration
NeoBundle 'tpope/vim-fugitive', { 'augroup' : 'fugitive'}
NeoBundle 'tpope/vim-git'
NeoBundleLazy 'gregsexton/gitv', { 'depends' : [ 'tpope/vim-fugitive' ]
                               \ , 'autoload' : { 'commands' : 'Gitv' }
                               \ }

" Undo tree
NeoBundle 'sjl/gundo.vim'

NeoBundle 'lukerandall/haskellmode-vim'

NeoBundle 'tomasr/molokai'

NeoBundle 'scrooloose/syntastic'

NeoBundle 'godlygeek/tabular'

NeoBundle 'majutsushi/tagbar'

NeoBundle 'tomtom/tcomment_vim'

NeoBundle 'honza/vim-snippets'
NeoBundle 'Shougo/neosnippet.vim'

NeoBundle 'Lokaltog/vim-easymotion'

NeoBundle 'tpope/vim-endwise'

NeoBundleLazy 'jcf/vim-latex', { 'autoload' : { 'filetypes' : ['tex', 'latex', 'bib'] }
                             \ , 'name' : 'vim-latex'
                             \ }

NeoBundle 'tpope/vim-markdown'

NeoBundle 'chrisbra/NrrwRgn'

NeoBundle 'depuracao/vim-rdoc'

NeoBundleLazy 'lyokha/vim-xkbswitch', { 'autoload' :
                                    \   { 'filetypes' : [ 'tex'
                                                      \ , 'latex'
                                                      \ , 'bib'
                                                      \ , 'markdown'
                                                      \ ]
                                    \   }
                                    \ , 'name' : 'vim-xkbswitch'
                                    \ }

NeoBundle 'argtextobj.vim'

NeoBundle 'mhinz/vim-signify'

NeoBundle 'MPogoda/octave.vim--'

NeoBundle 'terryma/vim-expand-region'
