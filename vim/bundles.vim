" vim: foldmethod=marker
"
" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', { 'build' :
                          \   { 'mac'  : 'make -f make_mac.mak'
                          \   , 'unix' : 'make -f make_unix.mak'
                          \   }
                          \ , 'name' : 'vimproc'
                          \ }

NeoBundle 'Valloric/YouCompleteMe', { 'build' :
                                  \   { 'unix' : 'sh install.sh --clang-completer --system-libclang' }
                                  \ }

" Unite.vim
NeoBundle 'Shougo/unite.vim', { 'name' : 'unite.vim'
                            \ , 'depends' : 'vimproc'
                            \ }

NeoBundleLazy 'thinca/vim-unite-history', { 'depends' : 'unite.vim'
                                        \ , 'autoload' : { 'unite_sources' : 'history/command' }
                                        \ }
NeoBundleLazy 'Shougo/unite-help', { 'depends' : 'unite.vim'
                                 \ , 'autoload' : { 'unite_sources' : 'help' }
                                 \ }

NeoBundle 'bling/vim-airline'

" NeoBundleLazy 'Shougo/neocomplete.vim', { 'autoload' : { 'insert' : 1 } }

" NeoBundleLazy 'Rip-Rip/clang_complete', { 'autoload' : { 'filetypes' : ['c', 'cpp'] }
"                                       \ , 'name' : 'clang_complete'
"                                       \ }

NeoBundleLazy 'docunext/closetag.vim', { 'autoload' : { 'filetypes' : ['html', 'xml'] }
                                     \ , 'name' : 'closetag'
                                     \ }

" VCS Integration
NeoBundle 'tpope/vim-fugitive', { 'augroup' : 'fugitive'}
NeoBundle 'tpope/vim-git'
NeoBundleLazy 'gregsexton/gitv', { 'depends' : [ 'tpope/vim-fugitive' ]
                               \ , 'autoload' : { 'commands' : 'Gitv' }
                               \ }
" {{{ GitV hotkeys
" \gv -> full repo view, \gV -> file view
" <cr> -> view commit, <C-n>/<C-p> jump to next/previous commit and <cr>.
" o -> <cr> with split, O -> tab, s -> vsplit
" co -> checkout
" S -> diffstat
" yc -> copy SHA
" x/X -> next/previous branching point
" Folds are enabled
" }}}

" Undo tree
NeoBundleLazy 'mbbill/undotree', { 'autoload' : { 'commands' : 'UndotreeToggle' } }

NeoBundle 'lukerandall/haskellmode-vim'

NeoBundle 'tomasr/molokai'

NeoBundle 'scrooloose/syntastic'

" NeoBundle 'godlygeek/tabular'
NeoBundleLazy 'godlygeek/tabular', { 'autoload' : { 'commands' : 'Tabularize' } }

NeoBundleLazy 'majutsushi/tagbar', { 'autoload' : { 'commands' : 'TagbarToggle' } }

NeoBundle 'tomtom/tcomment_vim'

" NeoBundle 'honza/vim-snippets'
" NeoBundle 'Shougo/neosnippet.vim'
" NeoBundle 'Shougo/neosnippet-snippets'

NeoBundle 'Lokaltog/vim-easymotion'

NeoBundle 'tpope/vim-endwise'

NeoBundleLazy 'tpope/vim-markdown', { 'autoload' : { 'filetypes' : [ 'markdown' ] } }

NeoBundle 'chrisbra/NrrwRgn'
" <leader>nr -> narrow region

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
" Defines _ia (_ inner argument) and _aa (_ an argument)

NeoBundle 'mhinz/vim-signify'

NeoBundle 'MPogoda/octave.vim--'

NeoBundle 'terryma/vim-expand-region'

NeoBundle 'nathanaelkane/vim-indent-guides'

NeoBundle 'sudo.vim'

NeoBundleLazy 'LaTeX-Box-Team/LaTeX-Box', { 'autoload' :
                                        \   { 'filetypes' : [ 'tex'
                                                          \ , 'latex'
                                                          \ ]
                                        \   }
                                        \ }
" {{{ LaTeX-Box
" C-xC-o completion
" [[ -> \begin
" ]] -> \end / \right / whatever
" n-f5 -- */ no-*
" v-f7 -- wrap into command
" ([ -- eqref
" (( -- \left(
" )) -- \item
" }}} LaTeX-Box

NeoBundle 'octol/vim-cpp-enhanced-highlight'

