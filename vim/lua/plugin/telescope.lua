local telescope = require('telescope')

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ['<c-u>'] = false,
                ['<c-d>'] = false,
                ['jj'] = require('telescope.actions').close,
                ['<esc>'] = require('telescope.actions').close,
            },
        },
    },
})

telescope.load_extension('lsp_handlers')

require('which-key').register({
    f = {
        name = '+find',
        b = { [[<cmd>Telescope buffers<cr>]], 'Buffers' },
        f = { [[<cmd>Telescope find_files<cr>]], 'Files' },
        g = { [[<cmd>Telescope git_status<cr>]], 'Git status' },
        o = { [[<cmd>Telescope oldfiles<cr>]], 'Oldfiles' },
    },
}, {
    prefix = '<leader>',
})
