command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <silent> <leader>ff :<C-u>Files<cr>
nnoremap <silent> <leader>fg :<C-u>GFiles<cr>
nnoremap <silent> <leader>fb :<C-u>Buffers<cr>
nnoremap <silent> <leader>f/ :<C-u>Rg<cr>
nnoremap <silent> <leader>fs :<C-u>Snippets<cr>
