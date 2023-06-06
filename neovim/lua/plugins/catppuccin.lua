local M = {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 10000,
}

function M.config()
    local catppuccin = require('catppuccin')
    catppuccin.setup({
        dim_inactive = { enabled = true },
        integrations = {
            fidget = true,
            leap = true,
            lsp_trouble = true,
            which_key = true,
        },
    })
    catppuccin.load()
end

return M
