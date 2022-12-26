local M = {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'kyazdani42/nvim-web-devicons',
        'nvim-lua/lsp-status.nvim',
        'catppuccin',
    },
}

function M.config()
    require('lsp-status').register_progress()
    require('lualine').setup({
        options = { globalstatus = true },
        extensions = { 'quickfix', 'fugitive' },
        sections = {
            lualine_c = {
                'filename',
                [[require('lsp-status').status()]],
            },
            lualine_x = {
                {
                    require('noice').api.status.message.get_hl,
                    cond = require('noice').api.status.message.has,
                },
                {
                    require('noice').api.status.command.get,
                    cond = require('noice').api.status.command.has,
                    color = { fg = '#ff9e64' },
                },
                {
                    require('noice').api.status.mode.get,
                    cond = require('noice').api.status.mode.has,
                    color = { fg = '#ff9e64' },
                },
                {
                    require('noice').api.status.search.get,
                    cond = require('noice').api.status.search.has,
                    color = { fg = '#ff9e64' },
                },
            },
        },
        theme = 'catppuccin',
    })
end

return M
