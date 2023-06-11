return {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPre',
    opts = {
        filetype_exclude = { 'help', 'packer', 'startify', 'Trouble' },
        buftype_exclude = { 'terminal', 'nofile' },
        char_highlight = 'LineNr',
        show_trailing_blankline_indent = false,
        use_treesitter = true,
        show_current_context = true,
        show_current_context_start = true,
    },
}
