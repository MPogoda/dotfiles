local gitsigns = require('gitsigns')

gitsigns.setup({
    current_line_blame = true,
    numhl = true,
    current_line_blame_opts = {
        delay = 2000,
    },
    on_attach = function(bufnr)
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
            buffer = bufnr,
        })

        wk.register({
            h = {
                s = { gitsigns.stage_hunk, 'Stage hunk' },
                r = { gitsigns.reset_hunk, 'Reset hunk' },
            },
        }, { buffer = bufnr, prefix = '<leader>', mode = 'v' })

        wk.register({
            [']c'] = { "&diff ? ']c' : '<cmd>Gitsigns next_hunk<cr>'", 'Next hunk', expr = true },
            ['[c'] = { "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<cr>'", 'Prev hunk', expr = true },
        }, { buffer = bufnr })

        wk.register({
            ['ih'] = { ':<c-u>Gitsigns select_hunk<cr>', 'HUNK' },
        }, { buffer = bufnr, mode = 'o' })
        wk.register({
            ['ih'] = { ':<c-u>Gitsigns select_hunk<cr>', 'HUNK' },
        }, { buffer = bufnr, mode = 'x' })
    end,
})
