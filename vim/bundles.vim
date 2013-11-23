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
" NeoBundle 'Shougo/unite-outline', { 'name' : 'unite-outline' }
" NeoBundle 'Shougo/unite-session', { 'name' : 'unite-session' }
" NeoBundle 'Shougo/unite-help'   , { 'name' : 'unite-help'    }
" NeoBundle 'thinca/vim-unite-history'

" NeoBundle 'mileszs/ack.vim'

NeoBundle 'bling/vim-airline'
NeoBundle 'Rip-Rip/clang_complete'
NeoBundle 'docunext/closetag.vim'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-git'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'lukerandall/haskellmode-vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'godlygeek/tabular'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'jcf/vim-latex'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'kana/vim-narrow'
NeoBundle 'depuracao/vim-rdoc'
NeoBundle 'lyokha/vim-xkbswitch'
NeoBundle 'argtextobj.vim'
NeoBundle 'hexHighlight.vim'
NeoBundle 'mhinz/vim-signify'
NeoBundle 'L9'
NeoBundle 'MPogoda/octave.vim--'
