local M = {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'kyazdani42/nvim-web-devicons',
        'nvim-lua/lsp-status.nvim',
        'catppuccin',
    },
    event = 'BufReadPre',
}

function M.config()
    require('lsp-status').register_progress()
    require('lualine').setup({
        options = { globalstatus = true },
        extensions = { 'quickfix', 'fugitive', 'lazy', 'trouble' },
        sections = {
            lualine_c = {
                'filename',
                [[require('lsp-status').status()]],
                [[require('nvim-lightbulb').get_status_text()]],
            },
        },
        theme = 'catppuccin',
    })
end

return M
