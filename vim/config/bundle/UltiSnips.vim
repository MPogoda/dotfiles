let g:UltiSnipsListSnippets = '<C-J>'
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

nnoremap <C-J> :call UltiSnips_ListSnippets()<Enter>
nnoremap <Leader><C-J> :UltiSnipsEdit<Enter>
