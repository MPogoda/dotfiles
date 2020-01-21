" vim: foldmethod=marker
"
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'docunext/closetag.vim'

" {{{ GIT Integration
Plug 'tpope/vim-fugitive'
" {{{ Fugitive hotkeys
" <leader>gs   Gstatus
"               D for diff
"               r for reload
" <leader>gl   Glog
" <leader>gd   Gdiff
" <leader>gw   Gwrite
" <leader>gb   Gblame
" }}} Fugitive hotkeys
Plug 'gregsexton/gitv'
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

Plug 'mbbill/undotree'

Plug 'godlygeek/tabular'

Plug 'majutsushi/tagbar'

Plug 'tomtom/tcomment_vim'

Plug 'Lokaltog/vim-easymotion'
" Start with <leader><leader>

Plug 'tpope/vim-surround'
" {{{ Surround mappings
" ds   delete
" cs   change
" ys   create with motion
" S    create in visual mode
" }}} Surround mappings

Plug 'tpope/vim-endwise'

Plug 'airblade/vim-gitgutter'

Plug 'terryma/vim-expand-region'
" + to expand, _ to shrink

Plug 'Yggdroot/indentLine'

Plug 'Valloric/ListToggle'
" <leader>q -> quickfix list
" <leader>w -> location list

Plug 'davidosomething/vim-colors-meh'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'kien/rainbow_parentheses.vim'

Plug 'mhinz/vim-startify'
Plug 'tpope/vim-obsession'

Plug 'sheerun/vim-polyglot'
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

Plug 't9md/vim-choosewin'
" nmap - <Plug>(choosewin)

Plug 'neomake/neomake'

Plug 'jceb/vim-orgmode'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" {{{ fzf
" <leader>ff Search filenames.
" <leader>fg Search git filenames.
" <leader>fb Search buffers.
" <leader>fa Search text using Ag.
" <leader>fs Search snippets.
" }}} fzf

Plug 'herringtondarkholme/yats'
Plug 'StanAngeloff/php.vim'
Plug 'othree/yajs.vim'

Plug 'ntpeters/vim-better-whitespace'

Plug 'editorconfig/editorconfig-vim'
