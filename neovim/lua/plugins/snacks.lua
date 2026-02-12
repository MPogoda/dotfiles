local M = {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@class snacks.Config
    opts = {},
    dependencies = { 'echasnovski/mini.icons' },
}

M.opts['bigfile'] = {}
M.opts['dashboard'] = {}
M.opts['indent'] = {}
M.opts['lazygit'] = {}
M.opts['picker'] = {
    layout = 'ivy',
    matcher = {
        cwd_bonus = true,
        frecency = true,
    },
    win = {
        input = {
            keys = {
                ['<Esc>'] = { 'cancel', mode = 'i' },
                ['jj'] = { 'cancel', mode = 'i' },
            },
        },
    },
}
M.opts['scope'] = {}
M.opts['statuscolumn'] = {}
M.opts['terminal'] = {}
M.opts['words'] = {}

M.keys = {
    {
        '<leader>gl',
        function()
            require('snacks').lazygit()
        end,
        desc = 'lazygit',
    },
    {
        '<leader>gg',
        function()
            require('snacks').lazygit.log_file()
        end,
        desc = 'lazygit THIS',
    },
    {
        '<c-/>',
        function()
            require('snacks').terminal()
        end,
        mode = { 'n', 't' },
        desc = 'Toggle terminal',
    },
    {
        ']]',
        function()
            require('snacks').words.jump(vim.v.count1)
        end,
        desc = 'Next Reference',
        mode = { 'n', 't' },
    },
    {
        '[[',
        function()
            require('snacks').words.jump(-vim.v.count1)
        end,
        desc = 'Prev Reference',
        mode = { 'n', 't' },
    },
    -- Picker keybinds
    {
        '<leader>fb',
        function()
            Snacks.picker.buffers({ layout = 'select' })
        end,
        desc = 'Buffers',
    },
    {
        '<leader>ff',
        function()
            Snacks.picker.files()
        end,
        desc = 'Files',
    },
    {
        '<leader>fG',
        function()
            Snacks.picker.git_status()
        end,
        desc = 'Git status',
    },
    {
        '<leader>fg',
        function()
            Snacks.picker.grep()
        end,
        desc = 'Live Grep',
    },
    {
        '<leader>fo',
        function()
            Snacks.picker.recent()
        end,
        desc = 'Recent files',
    },
    {
        '<leader>f/',
        function()
            Snacks.picker.grep_word()
        end,
        desc = 'Grep current word',
    },
    {
        '<leader>f:',
        function()
            Snacks.picker.commands()
        end,
        desc = 'Commands',
    },
    {
        '<leader>fk',
        function()
            Snacks.picker.keymaps()
        end,
        desc = 'Keymaps',
    },
    {
        '<leader>fh',
        function()
            Snacks.picker.help()
        end,
        desc = 'Help',
    },
    {
        '<leader>fd',
        function()
            Snacks.picker.diagnostics()
        end,
        desc = 'Diagnostics',
    },
    {
        '<leader>fn',
        function()
            Snacks.picker.files({ cwd = vim.fn.stdpath('config') })
        end,
        desc = 'Nvim config',
    },
}

return M
