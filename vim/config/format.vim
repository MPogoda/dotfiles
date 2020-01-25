set autoindent       " automatically indent new lines
set formatoptions+=o " continue comment marker in new lines
set formatoptions+=n " recognize numbered lists
set formatoptions+=j " remove a comment leader when joining lines
set formatoptions+=l " don't wrap line automatically if it was longer before insert
set textwidth=118    " hard-wrap long lines as you type them
set tabstop=4        " render TABs using this many spaces
set expandtab        " insert spaces when TAB is pressed
set softtabstop=4    " ... this many spaces
set shiftwidth=4     " indentation amount for < and > commands

" repeat last character to the maximum width of current line
nnoremap <leader>- :execute 's/.$/'. repeat('&', &textwidth+1) .'/'<Enter>
      \:execute 's/\%>'. &textwidth .'v.//g'<Enter>

