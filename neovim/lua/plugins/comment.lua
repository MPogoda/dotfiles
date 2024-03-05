return {
    {
        'echasnovski/mini.comment',
        version = false,
        dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
        opts = {
            custom_commentstring = function()
                return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
            end,
        },
        keys = { { 'gc', mode = { 'n', 'v' }, desc = '+comment' } },
    },
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        opts = { enable_autocmd = false },
        lazy = true,
    },
}
