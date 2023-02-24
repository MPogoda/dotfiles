local M = {
    'folke/which-key.nvim',
}

function M.config()
    require('which-key').setup({
        plugins = {
            spelling = { enabled = true },
        },
        window = { position = 'top' },
    })
end

return M
