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

map('i', '<c-l>', [[vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<c-l>']], { expr = true })
map('s', '<c-l>', [[vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<c-l>']], { expr = true })
-- Jump forward or backward
map('i', '<tab>', [[vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<tab>']], { expr = true })
map('s', '<tab>', [[vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<tab>']], { expr = true })
map('i', '<s-tab>', [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<s-tab>']], { expr = true })
map('s', '<s-tab>', [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<s-tab>']], { expr = true })
