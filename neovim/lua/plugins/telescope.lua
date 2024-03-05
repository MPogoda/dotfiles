local M = {
    'nvim-telescope/telescope.nvim',
    cmd = { 'Telescope' },
    dependencies = {
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
    vim.keymap.set('n', '<leader>fb', function()
        require('telescope.builtin').buffers({ theme = 'get_dropdown' })
    end, { desc = 'Buffers' })
    vim.keymap.set('n', '<leader>ff', function()
        require('telescope.builtin').find_files({ theme = 'get_dropdown' })
    end, { desc = 'Files' })
    vim.keymap.set('n', '<leader>fg', function()
        require('telescope.builtin').git_status({ theme = 'get_dropdown' })
    end, { desc = 'Git status' })
    vim.keymap.set('n', '<leader>fo', function()
        require('telescope.builtin').oldfiles()
    end, { desc = 'Oldfiles' })
    vim.keymap.set('n', '<leader>f/', function()
        require('telescope.builtin').grep_string()
    end, { desc = 'Grep string' })
    vim.keymap.set('n', '<leader>fr', function()
        require('telescope.builtin').resume()
    end, { desc = 'Resume' })
    vim.keymap.set('n', '<leader>fk', function()
        require('telescope.builtin').keymaps()
    end, { desc = 'Keymaps' })
    vim.keymap.set('n', '<leader>fh', function()
        require('telescope.builtin').help_tags()
    end, { desc = 'Help' })
    vim.keymap.set('n', '<leader>fd', function()
        require('telescope.builtin').diagnostics()
    end, { desc = 'Help' })
end

return M
