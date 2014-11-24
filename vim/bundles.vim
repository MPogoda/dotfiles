" vim: foldmethod=marker
"
" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', { 'build' :
                          \   { 'unix' : 'make -f make_unix.mak' }
                          \ , 'name' : 'vimproc'
                          \ }

" {{{ Unite
NeoBundle 'Shougo/unite.vim', { 'name' : 'unite.vim'
                            \ , 'depends' : 'vimproc'
                            \ }
" {{{ Unite hotkeys
" <space>o recursive files
" <space>f files
" <space>b buffers
" <space>/ grep
" <space>l lines
" <space>; command
" <space>: history/command
" <space>m MRU files
" <space>y history/yank
" <space>u outline
" <space>n file/new
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
" Start with ,.

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

NeoBundle 'mhinz/vim-signify'

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

NeoBundle 'tomasr/molokai'
NeoBundle 'altercation/vim-colors-solarized'

NeoBundleLazy 'Rip-Rip/clang_complete', { 'autoload' :
                                      \   { 'filetypes' : [ 'cpp'
                                                        \ , 'c'
                                                        \ ]
                                      \   }
                                      \ }
NeoBundle 'honza/vim-snippets'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neosnippet.vim' " {{{
" <tab> for expand.
" }}} neosnippet.vim
NeoBundle 'Shougo/neocomplete.vim' " {{{
" <c-g> to UNDO completion
" }}} neocomplete.vim


