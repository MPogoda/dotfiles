set hidden " lets you switch buffers without saving

" switch to adjacent buffer in current window
nnoremap <C-PageUp> :bprev<Enter>
nnoremap <C-PageDown> :bnext<Enter>

" close current buffer while retaining window
nnoremap <Leader>$ :execute 'bnext<Bar>bdelete' bufnr('%')<Enter>

" reload current buffer while discarding changes
nnoremap <Leader>7 :edit!<Enter>
