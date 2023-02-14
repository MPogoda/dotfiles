local M = {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-calc',
        'hrsh7th/cmp-emoji',
        'f3fora/cmp-spell',
        'onsails/lspkind-nvim',
        'dmitmel/cmp-digraphs',
    },
}

function M.config()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    cmp.setup({
        completion = { completeopt = 'menu,menuone,noinsert' },
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        sources = {
            { name = 'nvim_lsp' },
            { name = 'path' },
            { name = 'luasnip' },
            { name = 'buffer', keyword_length = 5 },
            { name = 'calc' },
            -- { name = 'emoji' },
            {
                name = 'spell',
                option = {
                    enable_in_context = function()
                        return require('cmp.config.context').in_treesitter_capture('spell')
                    end,
                },
            },
            -- { name = 'digraphs' },
        },
        mapping = cmp.mapping.preset.insert({
            ['<c-d>'] = cmp.mapping.scroll_docs(-4),
            ['<c-f>'] = cmp.mapping.scroll_docs(4),
            ['<c-space>'] = cmp.mapping.complete(),
            ['<c-e>'] = cmp.mapping.close(),
            ['<cr>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),
        }),
        experimental = { ghost_text = true },
        formatting = {
            format = lspkind.cmp_format({
                with_text = false,
                menu = {
                    buffer = '[bf]',
                    nvim_lsp = '[lsp]',
                    path = '[pth]',
                    spell = '[spl]',
                    luasnip = '[snp]',
                },
            }),
        },
    })

    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' },
        },
    })

    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' },
            { name = 'cmdline' },
        }),
    })
end

return M
