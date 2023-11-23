vim.g.skip_ts_context_commentstring_module = true

return {
    {
        'echasnovski/mini.comment',
        version = false,
        event = 'BufReadPost',
        dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
        config = true,
    },
    { 'JoosepAlviste/nvim-ts-context-commentstring', event = 'BufReadPost', config = true },
}
