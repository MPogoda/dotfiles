local gitsigns = require('gitsigns')

gitsigns.setup({
    current_line_blame = true,
    numhl = true,
    current_line_blame_opts = { delay = 2000 },
    on_attach = function()
        local wk = require('which-key')
        wk.register({
            h = {
                name = '+hunks',
                b = {
                    function()
                        gitsigns.blame_line({ full = true })
                    end,
                    'Blame line',
                },
                s = { gitsigns.stage_hunk, 'Stage hunk' },
                r = { gitsigns.reset_hunk, 'Reset hunk' },
                S = { gitsigns.stage_buffer, 'Stage ALL' },
                u = { gitsigns.undo_stage_hunk, 'Undo stage' },
                R = { gitsigns.reset_buffer, 'Reset ALL' },
                p = { gitsigns.preview_hunk, 'Preview hunk' },
                d = { gitsigns.diffthis, 'diffthis' },
            },
            t = {
                b = { gitsigns.toggle_current_line_blame, 'Toggle current line blame' },
                d = { gitsigns.toggle_deleted, 'Toggle deleted' },
            },
        }, {
            prefix = '<leader>',
            buffer = 0,
        })

        wk.register({
            h = {
                s = { gitsigns.stage_hunk, 'Stage hunk' },
                r = { gitsigns.reset_hunk, 'Reset hunk' },
            },
        }, {
            buffer = 0,
            prefix = '<leader>',
            mode = 'v',
        })

        wk.register({
            [']c'] = {
                function()
                    if vim.wo.diff then
                        return ']c'
                    end
                    vim.schedule(gitsigns.next_hunk)
                    return '<Ignore>'
                end,
                'Next hunk',
                expr = true,
            },
            ['[c'] = {
                function()
                    if vim.wo.diff then
                        return '[c'
                    end
                    vim.schedule(gitsigns.prev_hunk)
                    return '<Ignore>'
                end,
                'Prev hunk',
                expr = true,
            },
        }, {
            buffer = 0,
        })

        wk.register({
            ['ih'] = { gitsigns.select_hunk, 'HUNK' },
        }, { buffer = 0, mode = 'o' })
        wk.register({
            ['ih'] = { gitsigns.select_hunk, 'HUNK' },
        }, { buffer = 0, mode = 'x' })
    end,
})
