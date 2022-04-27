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

local t = require('telescope.builtin')
require('which-key').register({
    f = {
        name = '+find',
        b = {
            function()
                t.buffers({ theme = 'get_dropdown' })
            end,
            'Buffers',
        },
        f = {
            function()
                t.find_files({ theme = 'get_dropdown' })
            end,
            'Files',
        },
        g = {
            function()
                t.git_status({ theme = 'get_dropdown' })
            end,
            'Git status',
        },
        o = { t.oldfiles, 'Oldfiles' },
        ['/'] = { t.grep_string, 'Grep string' },
    },
}, {
    prefix = '<leader>',
})
