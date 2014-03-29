set colorcolumn=+1 " show textwidth limit
autocmd ColorScheme * highlight! link ColorColumn StatusLineNC

if has('gui_running')
    colorscheme solarized
    set background=light
else
    colorscheme molokai
    set background=dark
endif
