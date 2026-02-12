local M = {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    lazy = false,
}

function M.config()
    require('lualine').setup({
        options = { globalstatus = true },
        extensions = { 'quickfix', 'fugitive', 'lazy', 'trouble' },
        sections = {
            lualine_c = {
                'filename',
                [[require('nvim-lightbulb').get_status_text()]],
            },
        },
    })
end

return M
