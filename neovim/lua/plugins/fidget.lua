local M = {
    'j-hui/fidget.nvim',
    config = function()
        require('fidget').setup({
            window = { blend = 0 },
        })
    end,
}

return M
