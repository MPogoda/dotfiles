return {
    'tpope/vim-fugitive',
    dependencies = {
        'tpope/vim-rhubarb',
    },
    keys = {
        { '<leader>gs', '<cmd>Git<cr>', desc = 'Status' },
        { '<leader>gc', '<cmd>Git commit --no-verify<cr>', desc = 'Commit [no verify]' },
        { '<leader>gw', '<cmd>Gwrite<cr>', desc = 'Stage' },
        { '<leader>gb', '<cmd>Git blame<cr>', desc = 'Blame' },
        { '<leader>gd', '<cmd>Gdiffsplit<cr>', desc = 'Diff' },
        { '<leader>go', '<cmd>GBrowse<cr>', desc = 'Open in …' },

        { '<leader>go', [[<cmd>'<,'>GBrowse<cr>]], mode = 'v', desc = 'Open in …' },
    },
}
