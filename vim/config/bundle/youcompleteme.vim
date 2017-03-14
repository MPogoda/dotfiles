nnoremap <leader>jd :YcmCompleter GoTo<cr>
" let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_fallback_conf.py'
let g:ycm_complete_in_comments_and_strings = 1
let g:ycm_key_list_select_completion = ['<c-n>', '<down>']
let g:ycm_key_list_previous_completion = ['<c-p>', '<up>']
let g:ycm_filetype_blacklist = { 'unite' : 1 }
let g:ycm_server_python_interpreter = 'python2'

