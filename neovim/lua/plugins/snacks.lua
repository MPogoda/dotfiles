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
}

return M
