require('gitsigns').setup({
    current_line_blame = true,
    current_line_blame_delay = 500,
})
require('which-key').register({
    h = {
        name = '+hunks',
        b = 'Blame line',
        p = 'Preview hunk',
        R = 'Reset ALL',
        r = 'Reset hunk',
        s = 'Stage hunk',
        S = 'Stage ALL',
        u = 'Undo stage',
        U = 'Undo stage ALL',
    },
}, {
    prefix = '<leader>',
})
