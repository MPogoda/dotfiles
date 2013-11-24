set hidden " lets you switch buffers without saving

" switch to adjacent buffer in current window
nnoremap <C-PageUp>   :bprev<cr>
nnoremap <C-PageDown> :bnext<cr>

" close current buffer while retaining window
nnoremap <Leader>$ :execute 'bnext<Bar>bdelete' bufnr('%')<cr>

" reload current buffer while discarding changes
nnoremap <Leader>e :edit!<cr>
