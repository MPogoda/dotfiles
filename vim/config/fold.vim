set foldenable
set foldmethod=syntax " syntax defines folds
set foldlevelstart=99 " close folds below this depth, initially

augroup ft_c
    au!
    au FileType c,cpp setlocal foldmethod=marker foldmarker={,}
augroup END
