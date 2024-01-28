local M = {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-calc',
        'hrsh7th/cmp-emoji',
        'f3fora/cmp-spell',
        'onsails/lspkind.nvim',
        'dmitmel/cmp-digraphs',
    },
}

function M.config()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    cmp.setup({
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'path' },
            { name = 'luasnip' },
            { name = 'buffer',                 keyword_length = 5 },
            { name = 'calc' },
            {
                name = 'spell',
                option = {
                    enable_in_context = function()
                        return require('cmp.config.context').in_treesitter_capture('spell')
                    end,
                },
            },
            { name = 'emoji', trigger_characters = { ':' }, option = { insert = true } },
        }),
        mapping = cmp.mapping.preset.insert({
            ['<c-d>'] = cmp.mapping.scroll_docs(-4),
            ['<c-f>'] = cmp.mapping.scroll_docs(4),
            ['<c-space>'] = cmp.mapping.complete({}),
            ['<c-e>'] = cmp.mapping.close(),
            ['<c-k>'] = cmp.mapping.complete({ config = { sources = { { name = 'digraphs' } } } }),
            ['<cr>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),
        }),
        experimental = { ghost_text = { hl_group = 'LspCodeLens' } },
        formatting = {
            expandable_indicator = true,
            fields = { 'menu', 'abbr', 'kind' },
            format = lspkind.cmp_format({
                mode = 'symbol',
                max_width = 50,
                symbol_map = {
                    buffer = 'b',
                    nvim_lsp = 'λ',
                    path = '[pth]',
                    spell = '[spl]',
                    luasnip = '[snp]',
                    emoji = '[em]',
                },
            }),
        },
    })

    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'buffer' },
        }),
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
