local M = {
    'catppuccin/nvim',
    name = 'catppuccin',
}

function M.config()
    local catppuccin = require('catppuccin')
    catppuccin.setup({
        dim_inactive = { enabled = true },
        integrations = {
            lsp_trouble = true,
            which_key = true,
            ts_rainbow = true,
            leap = true,
            fidget = true,
            native_lsp = { enabled = true },
        },
    })
    catppuccin.load()
end

return M
