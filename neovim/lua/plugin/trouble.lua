require('trouble').setup({})

require('which-key').register({
    x = { '<cmd>TroubleToggle<cr>', 'Troubles?' },
}, { prefix = '<leader>' })
