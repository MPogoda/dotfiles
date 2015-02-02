" vim: foldmethod=marker
"
" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

let g:neobundle#types#git#default_protocol = "ssh"

NeoBundle 'Shougo/vimproc', { 'build' :
                          \   { 'unix' : 'make -f make_unix.mak' }
                          \ , 'name' : 'vimproc'
                          \ }

NeoBundle 'Valloric/YouCompleteMe'
" {{{Build instruction for YCM
"   1. git submodule update --init --recursive
"   2. cd third_party/ycmd
"   3. mkdir -p build
"   4. cd build
"   5. cmake .. ../cpp
"   5a. (optional) ccmake . # configure
"   6. make
" }}}

" {{{ Unite
NeoBundle 'Shougo/unite.vim', { 'name' : 'unite.vim'
                            \ , 'depends' : 'vimproc'
                            \ }
" {{{ Unite hotkeys
" <leader>o recursive files
" <leader>f files
" <leader>b buffers
" <leader>/ grep
" <leader>l lines
" <leader>; command
" <leader>: history/command
" <leader>m MRU files
" <leader>y history/yank
" <leader>u outline
" <leader>n file/new
" }}}

NeoBundleLazy 'thinca/vim-unite-history', { 'depends' : 'unite.vim'
                                        \ , 'autoload' : { 'unite_sources' : 'history/command' }
                                        \ }

NeoBundleLazy 'Shougo/unite-outline', { 'depends' : 'unite.vim'
                                    \ , 'autoload' : { 'unite_sources' : 'outline' }
                                    \ }
" }}} Unite

NeoBundle 'bling/vim-airline'

NeoBundleLazy 'docunext/closetag.vim', { 'autoload' : { 'filetypes' : ['html', 'xml'] }
                                     \ , 'name' : 'closetag'
                                     \ }

" {{{ GIT Integration
NeoBundle 'tpope/vim-fugitive', { 'augroup' : 'fugitive'}
" {{{ Fugitive hotkeys
" <leader>gs   Gstatus
"               D for diff
"               r for reload
" <leader>gl   Glog
" <leader>gd   Gdiff
" <leader>gw   Gwrite
" <leader>gb   Gblame
" }}} Fugitive hotkeys
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
" }}} GIT Integration
"
" Undo tree
NeoBundleLazy 'mbbill/undotree', { 'autoload' : { 'commands' : 'UndotreeToggle' } }

NeoBundleLazy 'lukerandall/haskellmode-vim', { 'autoload' : { 'filetypes' : ['haskell', 'hs'] }
                                           \ }


NeoBundle 'scrooloose/syntastic'

NeoBundleLazy 'godlygeek/tabular', { 'autoload' : { 'commands' : 'Tabularize' } }

NeoBundleLazy 'majutsushi/tagbar', { 'autoload' : { 'commands' : 'TagbarToggle' } }

NeoBundle 'tomtom/tcomment_vim'

NeoBundle 'Lokaltog/vim-easymotion'
" Start with <leader><leader>

NeoBundle 'tpope/vim-surround'
" {{{ Surround mappings
" ds   delete
" cs   change
" ys   create with motion
" S    create in visual mode
" }}} Surround mappings

NeoBundle 'tpope/vim-endwise'

NeoBundleLazy 'tpope/vim-markdown', { 'autoload' : { 'filetypes' : [ 'markdown' ] } }
" {{{ Markdown maps
" <leader>= TOP LEVEL
" <leader>+ Second level
" <leader>- Update section separator
" }}} Markdown maps

NeoBundle 'chrisbra/NrrwRgn'
" <leader>nr -> narrow region

NeoBundleLazy 'lyokha/vim-xkbswitch', { 'autoload' :
                                    \   { 'filetypes' : [ 'tex'
                                                      \ , 'latex'
                                                      \ , 'bib'
                                                      \ , 'markdown'
                                                      \ ]
                                    \   }
                                    \ , 'name' : 'vim-xkbswitch'
                                    \ }

" NeoBundle 'mhinz/vim-signify'
NeoBundle 'airblade/vim-gitgutter'

NeoBundle 'MPogoda/octave.vim--'

NeoBundle 'terryma/vim-expand-region'
" + to expand, _ to shrink

NeoBundle 'nathanaelkane/vim-indent-guides'
" <leader>ig to show indent guides

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

NeoBundle 'Valloric/ListToggle'
" <leader>q -> quickfix list
" <leader>w -> location list

NeoBundle 'morhetz/gruvbox'

NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'

