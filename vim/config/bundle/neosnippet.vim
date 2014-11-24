imap <expr><tab> neosnippet#expandable_or_jumpable() ?
                \ "\<plug>(neosnippet_expand_or_jump)"
                \: pumvisible() ? "\<c-n>" : "\<tab>"
smap <expr><tab> neosnippet#expandable_or_jumpable() ?
                \ "\<plug>(neosnippet_expand_or_jump)"
                \: "\<tab>"

if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets,~/.vim/snippets'

