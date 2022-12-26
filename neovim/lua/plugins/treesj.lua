local M = {
    'Wansmer/treesj',
    event = 'BufReadPost',
    dependencies = { 'nvim-treesitter' },
    config = function()
        require('treesj').setup()
    end,
}

return M
