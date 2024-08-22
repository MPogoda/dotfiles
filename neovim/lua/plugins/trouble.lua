return {
    'folke/trouble.nvim',
    cmd = { 'Trouble' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
    keys = {
        { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'diagnostics (toggle)' },
        { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'buffer diagnostics (toggle)' },
        { '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'symbols (toggle)' },
        {
            '<leader>cl',
            '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
            desc = 'lsp definitions‥ (toggle)',
        },
        { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'loclist (toggle)' },
        { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'quickfix list (toggle)' },
    },
}
