set splitright " focus new window after vertical splitting
set splitbelow " focus new window after horizontal splitting

" add vertical split with current buffer that _follows_ current buffer.
nnoremap <silent> <leader><tab> :<C-u>let @z=&so<CR>:set so=0 noscb nowrap nofen<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>
