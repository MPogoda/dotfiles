nnoremap <silent> <leader>ff :<C-u>Files<cr>
nnoremap <silent> <leader>fg :<C-u>GFiles<cr>
nnoremap <silent> <leader>fG :<C-u>GFiles?<cr>
nnoremap <silent> <leader>fc :<C-u>Commits<cr>
nnoremap <silent> <leader>fb :<C-u>Buffers<cr>
nnoremap <silent> <leader>f/ :<C-u>Rg<cr>

" Using floating windows of Neovim to start fzf
if has('nvim-0.4.0')
    let $FZF_DEFAULT_OPTS .= '--color=bg:#20242C --border --layout=reverse'
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
    function! FloatingFZF()
        let width = min([&columns - 4, max([80, &columns - 20])])
        let height = min([&lines - 4, max([20, &lines - 10])])
        let top = ((&lines - height) / 2) - 1
        let left = (&columns - width) / 2
        let opts = { 'relative': 'editor',
            \ 'row': top,
            \ 'col': left,
            \ 'width': width,
            \ 'height': height,
            \ 'style': 'minimal'
            \}

        let top = "╭" . repeat("─", width - 2) . "╮"
        let mid = "│" . repeat(" ", width - 2) . "│"
        let bot = "╰" . repeat("─", width - 2) . "╯"
        let lines = [top] + repeat([mid], height - 2) + [bot]
        let s:buf = nvim_create_buf(v:false, v:true)
        call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
        call nvim_open_win(s:buf, v:true, opts)
        set winhl=Normal:Floating
        let opts.row += 1
        let opts.height -= 2
        let opts.col += 2
        let opts.width -= 4
        call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
        au BufWipeout <buffer> exe 'bw '.s:buf
      endfunction

    let g:fzf_layout = { 'window': 'call FloatingFZF()' }
endif
