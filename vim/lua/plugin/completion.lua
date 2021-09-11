local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'calc' },
        { name = 'emoji' },
        { name = 'spell' },
        { name = 'luasnip' },
    },
    mapping = {
        ['<c-p>'] = cmp.mapping.select_prev_item(),
        ['<c-n>'] = cmp.mapping.select_next_item(),
        ['<c-d>'] = cmp.mapping.scroll_docs(-4),
        ['<c-f>'] = cmp.mapping.scroll_docs(4),
        ['<c-space>'] = cmp.mapping.complete(),
        ['<c-e>'] = cmp.mapping.close(),
        ['<cr>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
    },
})
