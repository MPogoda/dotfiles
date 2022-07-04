require('which-key').register({
    ['$'] = { "<cmd>execute 'bnext<bar>bdelete' bufnr('%')<cr>", 'Close current buffer' },
    e = { '<cmd>edit!<cr>', 'Reload' },
    s = { '<cmd>write<cr>', 'Save' },
    ['!'] = { '/\\v^[<=>]{7}( <bar>$)/<cr>', 'Merge conflicts' },
}, {
    prefix = '<leader>',
})

vim.keymap.set('n', 'Y', 'y$', { noremap = true })

vim.keymap.set('i', 'jj', '<esc>', { silent = true, noremap = true })
vim.keymap.set('c', 'jj', '<esc>', {})

vim.keymap.set('n', '<c-l>', ':<c-u>nohlsearch<cr>', { noremap = true })

vim.keymap.set('n', 'gv', '`[v`]', { noremap = true }) -- last edited or pasted

vim.keymap.set('v', '>', '>gv', { noremap = true })
vim.keymap.set('v', '<', '<gv', { noremap = true })
