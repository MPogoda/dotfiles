return {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
        local wk = require('which-key')
        wk.setup({
            plugins = { spelling = { enabled = true } },
            window = { position = 'top' },
        })
        wk.register({
            t = { name = '+toggle' },
            h = { name = '+hunks' },
            f = { name = '+find' },
            g = { name = '+git' },
        }, { prefix = '<leader>', mode = { 'n', 'v' } })
    end,
}
