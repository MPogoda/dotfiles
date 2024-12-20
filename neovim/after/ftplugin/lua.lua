vim.keymap.set('n', '<leader><leader>x', '<cmd>source %<cr>', { desc = 'Load current file', buffer = 0 })
vim.keymap.set('v', '<leader>x', ':lua<cr>', { desc = 'Execute line', buffer = 0 })
