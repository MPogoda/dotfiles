let g:coc_node_path="/Users/mpohoda/.nvm/versions/node/v12.16.1/bin/node"

set updatetime=300

inoremap <silent><expr> <TAB>
     \ pumvisible() ? "\<C-n>" :
     \ <SID>check_back_space() ? "\<TAB>" :
     \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
 let col = col('.') - 1
 return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
 if (index(['vim','help'], &filetype) >= 0)
   execute 'h '.expand('<cword>')
 else
   call CocAction('doHover')
 endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>nr <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>nq  <Plug>(coc-format-selected)
nmap <leader>nq  <Plug>(coc-format-selected)

augroup mygroup
 autocmd!
 " Setup formatexpr specified filetype(s).
 autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
 " Update signature help on jump placeholder
 autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>na  <Plug>(coc-codeaction-selected)
nmap <leader>na  <Plug>(coc-codeaction-selected)

" Fix autofix problem of current line
nmap <leader>nf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <tab> <Plug>(coc-range-select)
xmap <silent> <tab> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
" Show all diagnostics
nnoremap <silent> <leader>nd  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <leader>ne  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>nc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <leader>no  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>ns  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>nj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>nk  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <leader>np  :<C-u>CocListResume<CR>
