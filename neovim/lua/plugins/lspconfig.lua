local M = {
    'neovim/nvim-lspconfig',
    name = 'lsp',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'nvimtools/none-ls.nvim',
        'nvimtools/none-ls-extras.nvim',
        'folke/which-key.nvim',
        'hrsh7th/cmp-nvim-lsp',
        'nvim-lua/plenary.nvim',
        'nvim-lua/lsp-status.nvim',
        'folke/neodev.nvim',
        'SmiteshP/nvim-navic',
        'aznhe21/actions-preview.nvim',
    },
}

local function nullLsHasFormatter(ft)
    local sources = require('null-ls.sources')
    local available = sources.get_available(ft, 'NULL_LS_FORMATTING')
    return #available > 0
end

local function attachFormatting(client)
    local ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local enable = nullLsHasFormatter(ft) == (client.name == 'null-ls')
    client.server_capabilities.documentFormattingProvider = enable
    -- format on save
    if client.server_capabilities.documentFormattingProvider then
        local group = vim.api.nvim_create_augroup('LspBufFormat', { clear = false })
        vim.api.nvim_clear_autocmds({ event = 'BufWritePre', group = group, buffer = 0 })
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = group,
            buffer = 0,
            callback = function()
                vim.lsp.buf.format({
                    filter = function(c)
                        return c.name == 'null-ls'
                    end,
                    bufnr = 0,
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

    local function on_attach(client)
        attachFormatting(client)

        if client.server_capabilities.documentSymbolProvider then
            require('nvim-navic').attach(client)
        end

        require('which-key').register({
            n = {
                name = '+lsp',
                d = { vim.lsp.buf.definition, 'Definition' },
                D = { vim.lsp.buf.declaration, 'Declaration' },
                t = { vim.lsp.buf.type_definition, 'Type definition' },
                i = { vim.lsp.buf.implementation, 'Implementation' },
                r = { vim.lsp.buf.references, 'References' },
                a = {
                    name = 'Actions',
                    r = { vim.lsp.buf.rename, 'Rename' },
                    c = {
                        require('actions-preview').code_actions,
                        'Code action',
                    },
                    C = { vim.lsp.buf.code_action, 'Code action' },
                },
                s = {
                    require('telescope.builtin').lsp_document_symbols,
                    'Symbols',
                },
                q = { vim.lsp.diagnostic.set_loclist, 'To loclist' },
            },
        }, { prefix = '<leader>', buffer = 0, noremap = true })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true, buffer = 0 })
        vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, { noremap = true, silent = true, buffer = 0 })

        lsp_status.on_attach(client)
    end

    require('neodev').setup({})

    local servers = {
        html = {},
        jsonls = {
            json = { format = { enable = true } },
        },
        rust_analyzer = {},
        lua_ls = {
            settings = {
                runtime = { version = 'LuaJIT' },
                workspace = {
                    checkThirdParty = false,
                    -- Tells lua_ls where to find all the Lua files that you have loaded
                    -- for your neovim configuration.
                    library = {
                        '${3rd}/luv/library',
                        unpack(vim.api.nvim_get_runtime_file('', true)),
                    },
                    -- If lua_ls is really slow on your computer, you can try this instead:
                    -- library = { vim.env.VIMRUNTIME },
                },
                completion = {
                    callSnippet = 'Replace',
                },
            },
        },
        hls = {},
        tsserver = {},
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
