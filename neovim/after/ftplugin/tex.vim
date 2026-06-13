setlocal spell
setlocal iskeyword+=:

inoremap <buffer> [[     \begin{
imap     <buffer> ]]     <Plug>LatexCloseCurEnv
nmap     <buffer> <F5>   <Plug>LatexToggleStarEnv
vmap     <buffer> <F7>   <Plug>LatexWrapSelection
inoremap <buffer> ([     \eqref{
inoremap <buffer> ((     \left(
inoremap <buffer> ))     \item
