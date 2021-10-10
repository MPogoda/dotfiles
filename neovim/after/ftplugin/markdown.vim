setlocal textwidth=78
setlocal spell

augroup markdown_preview
  autocmd!
  autocmd BufWritePost *.markdown :silent !markdown % > %.html &
augroup END
"
" insert or update section separator at end of current line
nmap <silent> <leader>- A-<esc><Leader>_

" format current line as a top-level heading in markdown (uses `z marker)
nmap <silent> <leader>= mzyypVr=:.+1g/^=\+/d<cr>`z<C-l>
" format current line as a second-level heading in markdown (uses `z marker)
nmap <silent> <leader>+ mzyypVr-:.+1g/^-\+/d<cr>`z<C-l>
