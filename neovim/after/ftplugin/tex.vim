setlocal spell
setlocal iskeyword+=:

imap <buffer> [[     \begin{
imap <buffer> ]]     <Plug>LatexCloseCurEnv
nmap <F5>            <Plug>LatexToggleStarEnv
vmap <buffer> <F7>   <Plug>LatexWrapSelection
imap <buffer> ([     \eqref{
imap <buffer> ((     \left(
imap <buffer> ))     \item
