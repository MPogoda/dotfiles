local M = {
    'nvim-telescope/telescope.nvim',
    cmd = { 'Telescope' },
    dependencies = {
        'folke/which-key.nvim',
        'nvim-lua/plenary.nvim',
        'gbrlsnchs/telescope-lsp-handlers.nvim',
        'nvim-tree/nvim-web-devicons',
    },
}

function M.config()
    local telescope = require('telescope')

    telescope.setup({
        defaults = {
            mappings = {
                i = {
                    ['<c-u>'] = false,
                    ['<c-d>'] = false,
                    ['jj'] = require('telescope.actions').close,
                    ['<esc>'] = require('telescope.actions').close,
                    ['<c-down>'] = require('telescope.actions').cycle_history_next,
                    ['<c-up>'] = require('telescope.actions').cycle_history_prev,
                },
            },
        },
    })

    telescope.load_extension('lsp_handlers')
end

function M.init()
    require('which-key').register({
        f = {
            name = '+find',
            b = {
                function()
                    require('telescope.builtin').buffers({ theme = 'get_dropdown' })
                end,
                'Buffers',
            },
            f = {
                function()
                    require('telescope.builtin').find_files({ theme = 'get_dropdown' })
                end,
                'Files',
            },
            g = {
                function()
                    require('telescope.builtin').git_status({ theme = 'get_dropdown' })
                end,
                'Git status',
            },
            o = {
                function()
                    require('telescope.builtin').oldfiles()
                end,
                'Oldfiles',
            },
            ['/'] = {
                function()
                    require('telescope.builtin').grep_string()
                end,
                'Grep string',
            },
        },
    }, { prefix = '<leader>' })
end

return M
