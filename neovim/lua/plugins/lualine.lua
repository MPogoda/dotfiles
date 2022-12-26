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
        },
        theme = 'catppuccin',
    })
end

return M
