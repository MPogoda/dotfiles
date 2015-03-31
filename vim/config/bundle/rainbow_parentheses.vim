function! Load_Rainbow()
    call rainbow_parentheses#load(0)
    call rainbow_parentheses#load(1)
    call rainbow_parentheses#load(2)
    call rainbow_parentheses#activate()
endfunction

augroup TasteTheRainbow
    autocmd!
    autocmd VimEnter,BufRead,BufWinEnter,BufNewFile * call Load_Rainbow()
augroup END
