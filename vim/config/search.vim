nohlsearch

set incsearch   " incremental search
set hlsearch    " highlight search results
set ignorecase  " make searching case insensitive
set smartcase   " ... unless the query has capital letters

" make <C-L> (redraw screen) also turn off search highlighting until the next search
nnoremap <C-l> :nohlsearch<cr><C-l>

" list all occurrences of word under cursor in current buffer
nnoremap <Leader>* [I

" find merge conflict markers
nnoremap <leader>! /\v^[<=>]{7}( <Bar>$)/<cr>
