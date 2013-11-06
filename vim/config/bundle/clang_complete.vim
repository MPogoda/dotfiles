" open quickfix window on error.
let g:clang_complete_copen = 1
" periodically update the quickfix window.
let g:clang_periodic_quickfix = 1
" do some snippets magic on code placeholders.
let g:clang_snippets = 1
let g:clang_snippets_engine = "ultisnips"
" preview window will be closed automatically after a completion.
let g:clang_close_preview = 1
" Additionnal compilation argument passed to libclang.
let g:clang_user_options = '-std=c++11'
" use libclang directly.
let g:clang_use_library = 1
" absolute path where libclang is available.
let g:clang_library_path = "/usr/lib/llvm/"
" complete preprocessor macros and constants.
let g:clang_complete_macros = 1
" complete code patterns.
let g:clang_complete_patterns = 1
