vim.keymap.set('n', '<leader>$', "<cmd>execute 'bnext<bar>bdelete' bufnr('%')<cr>", { desc = 'Close current buffer!' })
vim.keymap.set('n', '<leader>e', '<cmd>edit!<cr>', { desc = 'R[e]load' })
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', { desc = '[W]rite' })

vim.keymap.set('n', '<leader>ts', function()
    vim.wo.spell = not vim.wo.spell
end, { desc = 'Spell?' })

vim.keymap.set('n', 'Y', 'y$', { noremap = true })

vim.keymap.set('i', 'jj', '<esc>', { silent = true, noremap = true })
vim.keymap.set('c', 'jj', '<esc>', {})

vim.keymap.set('n', 'gv', '`[v`]', { noremap = true }) -- last edited or pasted

vim.keymap.set('v', '>', '>gv', { noremap = true })
vim.keymap.set('v', '<', '<gv', { noremap = true })

vim.keymap.set('n', '<C-Left>', '<cmd>bprevious<cr>')
vim.keymap.set('n', '<C-Right>', '<cmd>bnext<cr>')

vim.keymap.set({ 'i', 'n' }, '<esc>', '<cmd>nohlsearch<cr><esc>')

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>te', vim.diagnostic.open_float, { desc = 'Show diagnostic [e]rror message' })
