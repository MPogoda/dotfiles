set scrolloff=3   " context lines around cursor
set scrolljump=5  " minimum number of lines to scroll

" retain relative cursor position when paging
nnoremap <PageUp>   <C-U>
nnoremap <PageDown> <C-D>

" Swap (j-gj) and (k-gk) movements
noremap j gj
noremap k gk
noremap gj j
noremap gk k
