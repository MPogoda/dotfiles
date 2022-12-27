local M = {
    'yamatsum/nvim-cursorline',
    event = 'BufReadPost',
    config = function()
        require('nvim-cursorline').setup({})
    end,
}
return M
