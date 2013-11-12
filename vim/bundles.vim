" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', { 'build': {
      \ 'windows': 'make -f make_mingw32.mak',
      \ 'cygwin': 'make -f make_cygwin.mak',
      \ 'mac': 'make -f make_mac.mak',
      \ 'unix': 'make -f make_unix.mak',
      \ } }
" Fuzzy search
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/unite-session'
NeoBundle 'Shougo/unite-help'
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'mileszs/ack.vim'

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
