require('which-key').register({
    g = {
        name = '+git',
        s = { '<cmd>Git<cr>', 'Status' },
        w = { '<cmd>Gwrite<cr>', 'Stage' },
        b = { '<cmd>Git blame<cr>', 'Blame' },
        d = { '<cmd>Gdiffsplit<cr>', 'Diff' },
        D = { '<cmd>DiffviewOpen<cr>', 'Diff ALL' },
    },
}, {
    prefix = '<leader>',
})
