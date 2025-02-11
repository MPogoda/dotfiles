return {
    'folke/which-key.nvim',
    event = 'VimEnter',
    dependencies = { 'echasnovski/mini.icons' },
    config = function()
        local wk = require('which-key')
        wk.setup({ preset = 'modern' })
        wk.add({
            mode = { 'n', 'v' },
            { '<leader>t', group = '+toggle' },
            { '<leader>h', group = '+hunks' },
            { '<leader>f', group = '+find' },
            { '<leader>g', group = '+git' },
            { '<leader>n', group = '+lsp' },
            { '<leader>na', group = '+action' },
            { '<leader>s', group = '+bolt' },
        })
    end,
}
