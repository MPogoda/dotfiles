require('gitsigns').setup({
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
                b = { '<cmd>lua require("gitsigns").blame_line({full=true})<cr>', 'Blame line' },
                s = { '<cmd>Gitsigns stage_hunk<cr>', 'Stage hunk' },
                r = { '<cmd>Gitsigns reset_hunk<cr>', 'Reset hunk' },
                S = { '<cmd>Gitsigns stage_buffer<cr>', 'Stage ALL' },
                u = { '<cmd>Gitsigns undo_stage_hunk<cr>', 'Undo stage' },
                R = { '<cmd>Gitsigns reset_buffer<cr>', 'Reset ALL' },
                p = { '<cmd>Gitsigns preview_hunk<cr>', 'Preview hunk' },
                d = { '<cmd>Gitsigns diffthis<cr>', 'diffthis' },
            },
            t = {
                b = {
                    '<cmd>Gitsigns toggle_current_line_blame<cr>',
                    'Toggle current line blame',
                },
                d = { '<cmd>Gitsigns toggle_deleted<cr>', 'Toggle deleted' },
            },
        }, {
            prefix = '<leader>',
            buffer = bufnr,
        })

        wk.register({
            h = {
                s = { '<cmd>Gitsigns stage_hunk<cr>', 'Stage hunk' },
                r = { '<cmd>Gitsigns reset_hunk<cr>', 'Reset hunk' },
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
