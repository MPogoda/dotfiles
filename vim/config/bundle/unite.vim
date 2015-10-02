" Open unite buffer in Insert Mode immediately.
call unite#custom#profile('default', 'context', {
                        \ 'start_insert' : 1
                        \ })

" Replaces fuzzyfinder
nnoremap <silent> <leader>g :<c-u>Unite -buffer-name=gitfiles file_rec/git:--cached:--others:--exclude-standard<cr>
" Replaces fuzzyfinder
nnoremap <silent> <leader>o :<C-u>Unite -buffer-name=files file_rec/async:!<cr>
" Replaces NERDTree
nnoremap <silent> <leader>f :<C-u>Unite -buffer-name=files -profile-name=files file<cr>
" Create new file
nnoremap <silent> <leader>n :<C-u>Unite -buffer-name=New -profile-name=files file/new<cr>

" Quickly find a buffer
nnoremap <silent> <leader>b :<C-u>Unite -quick-match -buffer-name=buffers buffer<cr>

nnoremap <silent> <leader>/ :<C-u>Unite -buffer-name=grep grep:.<cr>

nnoremap <silent> <leader>l :<C-u>Unite -buffer-name=lines line<cr>
nnoremap <silent> <leader>; :<C-u>Unite -buffer-name=commands command<cr>
nnoremap <silent> <leader>: :<C-u>Unite -buffer-name=commands history/command<cr>

nnoremap <silent> <leader>m :<C-u>Unite -buffer-name=mrus file_mru<cr>

let g:unite_source_history_yank_enable = 1
nnoremap <silent> <leader>y :<C-u>Unite -buffer-name=yanks history/yank<cr>

nnoremap <silent> <leader>u :<C-u>Unite -buffer-name=Outline outline<cr>


autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " Overwrite settings.
  imap <silent><buffer><expr> <C-s> unite#do_action('split')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  " Enable navigation with control-j and control-k in insert mode
  imap <silent><buffer> <C-j> <Plug>(unite_select_next_line)
  imap <silent><buffer> <C-k> <Plug>(unite_select_previous_line)
  " Quit from insert mode
  imap <silent><buffer> <C-q> <Plug>(unite_exit)
endfunction

let g:unite_source_rec_max_cache_files = 0
call unite#custom#source('file_rec,file_rec/async', 'max_candidates', 0)

if executable('ag')
    " Use ag in unite grep source.
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--line-numbers --nocolor --nogroup --hidden --ignore ' .
                                        \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_source_grep_recursive_opt = ''
    " let g:unite_source_rec_async_command = 'ag --follow --nocolor --nogroup -g ""'
elseif executable('ack-grep')
    " Use ack in unite grep source.
    let g:unite_source_grep_command = 'ack-grep'
    let g:unite_source_grep_default_opts = '--no-heading --no-color -a -H'
    let g:unite_source_grep_recursive_opt = ''
    " let g:unite_source_rec_async_command = 'ack -f --nofilter'
endif
