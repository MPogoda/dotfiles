let g:fuf_modesDisable = ['mrucmd']
let g:fuf_previewHeight = 0
let g:fuf_keyOpenSplit = '<Leader>2'
let g:fuf_keyOpenVsplit = '<Leader>3'

nnoremap <Leader>o :FufFileWithCurrentBufferDir<Enter>
nnoremap <Leader>O :FufMruFile<Enter>
nnoremap <Leader>6 :FufBuffer<Enter>
nnoremap <Leader>/ :FufLine<Enter>
