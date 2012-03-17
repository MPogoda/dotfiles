nnoremap <Leader>xo :ScreenShell<Enter>
nnoremap <Leader>xc :ScreenQuit<Enter>
nnoremap <Leader>xs :ScreenSend<Enter>
vnoremap <Leader>xs :ScreenSend<Enter>

let g:ScreenImpl = 'Tmux'
" start tmux with 256 color support
let g:ScreenShellTmuxInitArgs = '-2'
