" make it more colourful.
let NERDChristmasTree = 1
" specify which files the NERD tree should ignore.
let NERDTreeIgnore=['.o$', '\~$']
" determine where NERD tree window is placed on the screen.
let NERDTreeWinPos = 'right'
" disable the 'Bookmarks' label 'Press ? for help' text.
let NERDTreeMinimalUI=1

nnoremap <Leader>f :NERDTreeToggle<CR>
nnoremap <Leader>F :NERDTreeFind<CR>
