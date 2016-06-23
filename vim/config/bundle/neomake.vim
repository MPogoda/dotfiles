autocmd! BufWritePost * Neomake

let g:neomake_cpp_enable_makers = ['clang', 'clangtidy']
let g:neomake_cpp_clang_args = ['-std=c++14']
