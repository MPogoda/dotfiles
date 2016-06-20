" vim: foldmethod=marker
"
" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

let g:neobundle#types#git#default_protocol = "ssh"

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

NeoBundle 'vim-airline/vim-airline'

NeoBundle 'docunext/closetag.vim'

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
NeoBundle 'gregsexton/gitv', { 'depends' : [ 'tpope/vim-fugitive' ] }
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
NeoBundle 'mbbill/undotree'

NeoBundle 'godlygeek/tabular'

NeoBundle 'majutsushi/tagbar'

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

NeoBundle 'lyokha/vim-xkbswitch'

NeoBundle 'airblade/vim-gitgutter'

NeoBundle 'terryma/vim-expand-region'
" + to expand, _ to shrink

NeoBundle 'Yggdroot/indentLine'

NeoBundle 'Valloric/ListToggle'
" <leader>q -> quickfix list
" <leader>w -> location list

NeoBundle 'morhetz/gruvbox'

NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'

NeoBundle 'kien/rainbow_parentheses.vim'

NeoBundle 'mhinz/vim-startify'
NeoBundle 'tpope/vim-obsession'

NeoBundle 'sheerun/vim-polyglot'
" {{{ Markdown maps
" <leader>= TOP LEVEL
" <leader>+ Second level
" <leader>- Update section separator
" }}} Markdown maps
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

NeoBundle 't9md/vim-choosewin'
" nmap - <Plug>(choosewin)
