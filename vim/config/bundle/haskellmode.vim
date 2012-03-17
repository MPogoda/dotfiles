autocmd BufEnter *.hs compiler ghc
autocmd BufEnter *.hs GHCReload
let g:ghc="/usr/bin/ghc"
let g:haddoc_docdir="/usr/share/doc/ghc/html/"
let g:haddock_browser="/usr/bin/chromium"
