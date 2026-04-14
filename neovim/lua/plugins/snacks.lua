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
M.opts['input'] = {}
M.opts['lazygit'] = {
    config = {
        os = {
            editPreset = 'nvim-remote',
            edit = '[ -z "$NVIM" ] && (nvim -- {{filename}}) || (nvim --server "$NVIM" --remote-tab {{filename}})',
            editAtLine = '[ -z "$NVIM" ] && (nvim +{{line}} -- {{filename}}) || (nvim --server "$NVIM" --remote-tab {{filename}} && nvim --server "$NVIM" --remote-send ":{{line}}<CR>")',
        },
    },
}
M.opts['notifier'] = {}
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
            require('snacks').picker.buffers({ layout = 'select' })
        end,
        desc = 'Buffers',
    },
    {
        '<leader>ff',
        function()
            require('snacks').picker.files()
        end,
        desc = 'Files',
    },
    {
        '<leader>fG',
        function()
            require('snacks').picker.git_status()
        end,
        desc = 'Git status',
    },
    {
        '<leader>fg',
        function()
            require('snacks').picker.grep()
        end,
        desc = 'Live Grep',
    },
    {
        '<leader>fo',
        function()
            require('snacks').picker.recent()
        end,
        desc = 'Recent files',
    },
    {
        '<leader>f/',
        function()
            require('snacks').picker.grep_word()
        end,
        desc = 'Grep current word',
    },
    {
        '<leader>f:',
        function()
            require('snacks').picker.commands()
        end,
        desc = 'Commands',
    },
    {
        '<leader>fk',
        function()
            require('snacks').picker.keymaps()
        end,
        desc = 'Keymaps',
    },
    {
        '<leader>fh',
        function()
            require('snacks').picker.help()
        end,
        desc = 'Help',
    },
    {
        '<leader>fd',
        function()
            require('snacks').picker.diagnostics()
        end,
        desc = 'Diagnostics',
    },
    {
        '<leader>fn',
        function()
            require('snacks').picker.files({ cwd = vim.fn.stdpath('config') })
        end,
        desc = 'Nvim config',
    },
}

return M
