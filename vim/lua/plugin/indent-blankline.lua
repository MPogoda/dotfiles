require('indent_blankline').setup({
    char = '┊',
    filetype_exclude = { 'help', 'packer' },
    buftype_exclude = { 'terminal', 'nofile' },
    char_highlight = 'LineNr',
    show_trailing_blankline_indent = false,
    use_treesitter = true,
})
