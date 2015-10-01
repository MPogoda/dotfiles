set shell=/bin/sh " use Bourne shell for command substitution
set history=9999  " remember this many commands & searches
set confirm       " ask user before aborting an action

" Check whether file is modified outside vim.
nnoremap <silent> <f1> :checktime<cr>
inoremap <silent> <f1> <esc>:checktime<cr>
