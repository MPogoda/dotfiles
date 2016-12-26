augroup ClangFormatOptions
    autocmd!

    autocmd FileType c,cpp map <buffer><leader>gq <plug>(operator-clang-format)
augroup END
