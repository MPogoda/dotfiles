require('trouble').setup({
    auto_close = true,
})

require('which-key').register({
    x = { '<cmd>TroubleToggle<cr>', 'Troubles?' },
}, { prefix = '<leader>' })