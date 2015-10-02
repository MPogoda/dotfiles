set shell=zsh
set confirm       " ask user before aborting an action

" Check whether file is modified outside vim.
nnoremap <silent> <f1> :checktime<cr>
inoremap <silent> <f1> <esc>:checktime<cr>
