call which_key#register('<space>', "g:which_key_map")

nnoremap <silent> <leader>      :<c-u>WhichKey '<space>'<cr>
vnoremap <silent> <leader>      :<c-u>WhichKey '<space>'<cr>
nnoremap <silent> <localleader> :<c-u>WhichKey  '_'<cr>
vnoremap <silent> <localleader> :<c-u>WhichKey  '_'<cr>

set timeoutlen=500

let g:which_key_use_floating_win = 1

let g:which_key_map = {}
let g:which_key_map['!'] = 'conflicts?'
let g:which_key_map['$'] = 'delete-buf'
let g:which_key_map['@'] = 'split-follow'
let g:which_key_map['-'] = 'fill-line'
let g:which_key_map['e'] = 'reload'
let g:which_key_map['q'] = 'quickfix'
let g:which_key_map['S'] = 'save-as'
let g:which_key_map['s'] = 'save'
let g:which_key_map['u'] = 'undotree'
let g:which_key_map['l'] = 'locations'

let g:which_key_map['_'] = {
    \ 'name': '+tcomment',
    \ }

let g:which_key_map['f'] = {
    \ 'name': '+fzf',
    \ 'f': 'files',
    \ 'g': 'git-files',
    \ 'G': 'git-changed-files',
    \ 'c': 'commits',
    \ 'b': 'buffers',
    \ '/': 'rg',
    \ }

let g:which_key_map['g'] = {
    \ 'name': '+git',
    \ 's': 'status',
    \ 'l': 'log',
    \ 'd': 'diff',
    \ 'w': 'stage',
    \ 'b': 'blame',
    \ 'v': 'commits',
    \ 'V': 'commits-in-file',
    \ }

let g:which_key_map['h'] = {
    \ 'name': '+hunk',
    \ 'p': 'preview',
    \ 's': 'stage',
    \ 'u': 'undo',
    \ }

let g:which_key_map['n'] = {
    \ 'name': '+complete',
    \ 'r': 'rename',
    \ 'q': 'format',
    \ 'a': 'action',
    \ 'f': 'autofix',
    \ 'd': 'diagnostics',
    \ 'e': 'extensions',
    \ 'c': 'commands',
    \ 'o': 'outline',
    \ 's': 'symbols',
    \ 'j': 'action-next',
    \ 'k': 'action-prev',
    \ 'p': 'resume-list',
    \ }

let g:which_key_map['t'] = {
    \ 'name': '+toggle',
    \ 'c': 'cursor-column',
    \ 'C': 'cursor-line',
    \ 'h': 'hl-search',
    \ 'l': 'list',
    \ 'n': 'number',
    \ 'N': 'relative-number',
    \ 'p': 'paste',
    \ 's': 'spell',
    \ 'z': 'fold-enable',
    \ }
