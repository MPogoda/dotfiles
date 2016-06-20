" vim: foldmethod=marker
"
Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
" {{{Build instruction for YCM
"   1. git submodule update --init --recursive
"   2. cd third_party/ycmd
"   3. mkdir -p build
"   4. cd build
"   5. cmake .. ../cpp
"   5a. (optional) ccmake . # configure
"   6. make
" }}}

Plugin 'vim-airline/vim-airline'

Plugin 'docunext/closetag.vim'

" {{{ GIT Integration
Plugin 'tpope/vim-fugitive'
" {{{ Fugitive hotkeys
" <leader>gs   Gstatus
"               D for diff
"               r for reload
" <leader>gl   Glog
" <leader>gd   Gdiff
" <leader>gw   Gwrite
" <leader>gb   Gblame
" }}} Fugitive hotkeys
Plugin 'gregsexton/gitv'
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

Plugin 'mbbill/undotree'

Plugin 'godlygeek/tabular'

Plugin 'majutsushi/tagbar'

Plugin 'tomtom/tcomment_vim'

Plugin 'Lokaltog/vim-easymotion'
" Start with <leader><leader>

Plugin 'tpope/vim-surround'
" {{{ Surround mappings
" ds   delete
" cs   change
" ys   create with motion
" S    create in visual mode
" }}} Surround mappings

Plugin 'tpope/vim-endwise'

Plugin 'lyokha/vim-xkbswitch'

Plugin 'airblade/vim-gitgutter'

Plugin 'terryma/vim-expand-region'
" + to expand, _ to shrink

Plugin 'Yggdroot/indentLine'

Plugin 'Valloric/ListToggle'
" <leader>q -> quickfix list
" <leader>w -> location list

Plugin 'morhetz/gruvbox'

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

Plugin 'kien/rainbow_parentheses.vim'

Plugin 'mhinz/vim-startify'
Plugin 'tpope/vim-obsession'

Plugin 'sheerun/vim-polyglot'
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

Plugin 't9md/vim-choosewin'
" nmap - <Plug>(choosewin)
