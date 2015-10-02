" be consistent with C and D which reach the end of line
nnoremap Y y$
set encoding=utf-8
set backspace=indent,eol,start

inoremap <silent> jj <esc>
cmap jj <esc>

" Move the character under the cursor to the end of the line.
nnoremap zl :let @z=@"<cr>x$p:let @"=@z<cr>

