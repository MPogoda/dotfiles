local M = {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
}

function M.config()
    local gitsigns = require('gitsigns')

    gitsigns.setup({
        current_line_blame = true,
        numhl = true,
        current_line_blame_opts = { delay = 2000 },
        on_attach = function()
            vim.keymap.set({ 'v', 'n' }, '<leader>hs', gitsigns.stage_hunk, { buffer = 0, desc = 'Stage hunk' })
            vim.keymap.set({ 'v', 'n' }, '<leader>hr', gitsigns.reset_hunk, { buffer = 0, desc = 'Reset hunk' })
            vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, { buffer = 0, desc = 'Stage ALL' })
            vim.keymap.set('n', '<leader>hu', gitsigns.undo_stage_hunk, { buffer = 0, desc = 'Undo stage' })
            vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer, { buffer = 0, desc = 'Reset ALL' })
            vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { buffer = 0, desc = 'Preview hunk' })
            vim.keymap.set('n', '<leader>hd', gitsigns.diffthis, { buffer = 0, desc = 'diffthis' })
            vim.keymap.set('n', '<leader>hb', function()
                gitsigns.blame_line({ full = true })
            end, { buffer = 0, desc = 'Blame line' })

            vim.keymap.set(
                'n',
                '<leader>tb',
                gitsigns.toggle_current_line_blame,
                { buffer = 0, desc = 'Toggle current line [b]lame' }
            )
            vim.keymap.set(
                'n',
                '<leader>td',
                gitsigns.toggle_current_line_blame,
                { buffer = 0, desc = 'Toggle [d]eleted' }
            )

            vim.keymap.set('n', ']c', function()
                if vim.wo.diff then
                    return ']c'
                end
                vim.schedule(gitsigns.next_hunk)
                return '<Ignore>'
            end, { desc = 'Next hunk', expr = true, buffer = 0 })
            vim.keymap.set('n', '[c', function()
                if vim.wo.diff then
                    return '[c'
                end
                vim.schedule(gitsigns.prev_hunk)
                return '<Ignore>'
            end, { desc = 'Prev hunk', expr = true, buffer = 0 })

            vim.keymap.set({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = 'HUNK', buffer = 0 })
        end,
    })
end

return M
