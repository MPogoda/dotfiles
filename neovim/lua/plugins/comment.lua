local M = {
    'echasnovski/mini.comment',
    version = false,
    event = 'BufReadPost',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    opts = {
        options = {
            custom_commentstring = function()
                return require('ts_context_commentstring.internal').calculate_commentstring({}) or vim.bo.commentstring
            end,
        },
    },
}

return M
