local M = {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'nvim-lua/lsp-status.nvim',
        'catppuccin',
        'otavioschwanck/arrow.nvim',
    },
    lazy = false,
}

function M.config()
    require('lsp-status').register_progress()
    require('lualine').setup({
        options = { globalstatus = true },
        extensions = { 'quickfix', 'fugitive', 'lazy', 'trouble' },
        sections = {
            lualine_c = {
                'filename',
                [[require('arrow.statusline').text_for_statusline_with_icons()]],
                [[require('lsp-status').status()]],
                [[require('nvim-lightbulb').get_status_text()]],
            },
        },
        theme = 'catppuccin',
    })
end

return M
