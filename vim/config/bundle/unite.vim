" Open unite buffer in Insert Mode immediately.
let g:unite_enable_start_insert = 1

" Directory to store unite configurations.
let g:unite_data_directory = "~/.cache/vim/unite"

" Replaces fuzzyfinder
nnoremap <leader>o :<C-u>Unite -buffer-name=files file_rec/async:!<cr>
" Replaces NERDTree
nnoremap <leader>f :<C-u>Unite -buffer-name files file<cr>

" Quickly find a buffer
nnoremap <leader>b :<C-u>Unite -quick-match -buffer-name=buffers buffer<cr>

nnoremap <leader>/ :<C-u>Unite -buffer-name=grep grep:.<cr>

nnoremap <leader>l :<C-u>Unite -buffer-name=lines line<cr>
nnoremap <leader>: :<C-u>Unite -buffer-name=commands command<cr>

nnoremap <leader>m :<C-u>Unite -buffer-name=mrus file_mru<cr>

let g:unite_source_history_yank_enable = 1
nnoremap <leader>y :<C-u>Unite -buffer-name=yanks history/yank<cr>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " Overwrite settings.
  imap <silent><buffer><expr> <C-s>     unite#do_action('split')
  imap <silent><buffer><expr> <C-v>     unite#do_action('vsplit')
endfunction
