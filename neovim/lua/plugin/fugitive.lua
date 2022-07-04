require('which-key').register({
    g = {
        name = '+git',
        s = { '<cmd>Git<cr>', 'Status' },
        w = { '<cmd>Gwrite<cr>', 'Stage' },
        b = { '<cmd>Git blame<cr>', 'Blame' },
        d = { '<cmd>Gdiffsplit<cr>', 'Diff' },
        o = { '<cmd>GBrowse<cr>', 'Open in …' },
    },
}, {
    prefix = '<leader>',
})

require('which-key').register({
    g = {
        name = '+git',
        o = { [[<cmd>'<,'>GBrowse<cr>]], 'Open in …' },
    },
}, {
    prefix = '<leader>',
    mode = 'v',
})
