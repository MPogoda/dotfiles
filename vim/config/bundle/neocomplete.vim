let g:acp_enableAtStartup = 0               " Disable AutoComplPop.

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3

inoremap <expr><c-g>        neocomplete#undo_completion()
inoremap <expr><tab>        pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><c-h>        neocomplete#smart_close_popup()."\<c-h>"
inoremap <expr><bs>         neocomplete#smart_close_popup()."\<c-h>"
inoremap <expr><c-y>        neocomplete#close_popup()
inoremap <expr><c-e>        neocomplete#cancel_popup()
inoremap <expr><c-x><c-u>   neocomplete#start_manual_complete()

autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags

if !exists('g:neocomplete#same_filetypes')
    let g:neocomplete#same_filetypes = {}
endif
" In cpp buffers, completes from c buffers.
let g:neocomplete#same_filetypes.cpp = 'c'
" In gitconfig buffers, completes from all buffers.
let g:neocomplete#same_filetypes.gitconfig = '_'
" In default, completes from all buffers.
let g:neocomplete#same_filetypes._ = '_'

if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

