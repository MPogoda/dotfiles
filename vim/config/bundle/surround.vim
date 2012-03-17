" allow lowercase "s" to activate surround plugin in visual mode
autocmd VimEnter * xmap s S

" switch between single and double quotes (uses `z marker)
"
" NOTE: we explicitly set a temporary marker (z) and restore
"       it after the surround operation because otherwise the
"       surround plugin will move the cursor to the opening
"       quote of the operand after the operation, instead of
"       keeping the cursor where it was before the operation
"
nmap <Leader>' mzcs"'`z
nmap <Leader>" mzcs'"`z
