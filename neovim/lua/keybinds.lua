local map = vim.api.nvim_set_keymap

require('which-key').register({
    ['$'] = { "<cmd>execute 'bnext<bar>bdelete' bufnr('%')<cr>", 'Close current buffer' },
    e = { '<cmd>edit!<cr>', 'Reload' },
    s = { '<cmd>write<cr>', 'Save' },
    ['!'] = { '/\\v^[<=>]{7}( <bar>$)/<cr>', 'Merge conflicts' },
}, {
    prefix = '<leader>',
})

map('n', 'Y', 'y$', { noremap = true })

map('i', 'jj', '<esc>', { silent = true, noremap = true })
map('c', 'jj', '<esc>', {})

map('n', '<c-l>', ':<c-u>nohlsearch<cr>', { noremap = true })

map('n', 'gv', '`[v`]', { noremap = true }) -- last edited or pasted

map('v', '>', '>gv', { noremap = true })
map('v', '<', '<gv', { noremap = true })

map(
    'i',
    '<c-e>',
    [[luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<c-e>']],
    { expr = true, silent = true, noremap = true }
)
map(
    's',
    '<c-e>',
    [[luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<c-e>']],
    { expr = true, silent = true, noremap = true }
)
-- Jump forward or backward
map(
    'i',
    '<tab>',
    [[luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<tab>']],
    { expr = true, silent = true }
)
map('i', '<s-tab>', [[<cmd>lua require('luasnip').jump(-1)<cr>]], { silent = true, noremap = true })

map('s', '<tab>', [[<cmd>lua require('luasnip').jump(1)<cr>]], { noremap = true, silent = true })
map('s', '<s-tab>', [[<cmd>lua require('luasnip').jump(-1)<cr>]], { noremap = true, silent = true })
