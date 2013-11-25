let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets,~/.vim/snippets'
let g:neosnippet#enable_snipmate_compatibility=1

imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ? "\<C-n>" : "\<TAB>")
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
smap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
