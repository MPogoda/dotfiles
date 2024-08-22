local M = {
    'neovim/nvim-lspconfig',
    name = 'lsp',
    lazy = false,
    dependencies = {
        {
            'nvimtools/none-ls.nvim',
            dependencies = { 'nvimtools/none-ls-extras.nvim' },
        },
        'folke/which-key.nvim',
        'hrsh7th/cmp-nvim-lsp',
        'nvim-lua/plenary.nvim',
        'nvim-lua/lsp-status.nvim',
        'SmiteshP/nvim-navic',
        'aznhe21/actions-preview.nvim',
    },
}

local function nullLsHasFormatter(ft)
    local sources = require('null-ls.sources')
    local available = sources.get_available(ft, 'NULL_LS_FORMATTING')
    return #available > 0
end

local function attachFormatting(client, bufNr)
    local ft = vim.api.nvim_buf_get_option(bufNr, 'filetype')
    local enable = nullLsHasFormatter(ft) == (client.name == 'null-ls')

    client.server_capabilities.documentFormattingProvider = enable
    -- format on save
    if client.server_capabilities.documentFormattingProvider then
        local group = vim.api.nvim_create_augroup('LspBufFormat', { clear = false })
        vim.api.nvim_clear_autocmds({ event = 'BufWritePre', group = group, buffer = bufNr })
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = group,
            buffer = bufNr,
            callback = function()
                vim.lsp.buf.format({
                    filter = function(c)
                        return c.name == 'null-ls'
                    end,
                    bufnr = bufNr,
                })
            end,
        })
    end
end

function M.config()
    local lsp_status = require('lsp-status')
    lsp_status.register_progress()
    vim.diagnostic.config({
        severity_sort = true,
    })
    vim.lsp.handlers['workspace/diagnostic/refresh'] = function(_, _, ctx)
        local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
        pcall(vim.diagnostic.reset, ns)
        return true
    end

    local function on_attach(client, bufNr)
        attachFormatting(client, bufNr)

        if client.server_capabilities.documentSymbolProvider then
            require('nvim-navic').attach(client, bufNr)
        end

        vim.keymap.set(
            'n',
            '<leader>nd',
            vim.lsp.buf.definition,
            { desc = 'Definition', buffer = bufNr, noremap = true, silent = true }
        )
        vim.keymap.set(
            'n',
            '<leader>nD',
            vim.lsp.buf.declaration,
            { desc = 'Declaration', buffer = bufNr, noremap = true, silent = true }
        )
        vim.keymap.set(
            'n',
            '<leader>nt',
            vim.lsp.buf.type_definition,
            { desc = 'Type definition', buffer = bufNr, noremap = true, silent = true }
        )
        vim.keymap.set(
            'n',
            '<leader>ni',
            vim.lsp.buf.implementation,
            { desc = 'Implementation', buffer = bufNr, noremap = true, silent = true }
        )
        vim.keymap.set(
            'n',
            '<leader>nr',
            vim.lsp.buf.references,
            { desc = 'References', buffer = bufNr, noremap = true, silent = true }
        )

        vim.keymap.set(
            'n',
            '<leader>nar',
            vim.lsp.buf.rename,
            { desc = 'Rename', buffer = bufNr, noremap = true, silent = true }
        )
        vim.keymap.set(
            'n',
            '<leader>nac',
            require('actions-preview').code_actions,
            { desc = 'Code action', buffer = bufNr, noremap = true, silent = true }
        )
        vim.keymap.set(
            'n',
            '<leader>naC',
            vim.lsp.buf.code_action,
            { desc = 'Code action', buffer = bufNr, noremap = true, silent = true }
        )
        vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, { noremap = true, silent = true, buffer = bufNr })

        lsp_status.on_attach(client)
    end

    local servers = {
        html = {},
        jsonls = {
            json = { format = { enable = true } },
        },
        rust_analyzer = {},
        lua_ls = {},
        hls = {},
        tsserver = {},
        pylsp = {},
    }

    local capabilities = vim.tbl_extend(
        'force',
        vim.lsp.protocol.make_client_capabilities(),
        require('cmp_nvim_lsp').default_capabilities()
    )
    capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)

    local options = { on_attach = on_attach, capabilities = capabilities }

    for server, opts in pairs(servers) do
        opts = vim.tbl_deep_extend('force', {}, options, opts or {})
        require('lspconfig')[server].setup(opts)
    end

    local null_ls = require('null-ls')
    null_ls.setup({
        sources = {
            require('none-ls.code_actions.eslint_d'),
            require('none-ls.diagnostics.eslint_d'),
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.prettierd,
        },
        on_attach = on_attach,
    })
end

return M
