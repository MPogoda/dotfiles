set colorcolumn=+1 " show textwidth limit
autocmd ColorScheme * highlight! link ColorColumn StatusLineNC

set regexpengine=1        " Do not use NFA because doxygen style will be slow
let g:load_doxygen_syntax=1 " Load doxygen syntax by default

if has('gui_running')
    colorscheme solarized
    set background=light
else
    colorscheme molokai
    set background=dark
endif
