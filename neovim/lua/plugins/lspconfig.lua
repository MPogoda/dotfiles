local M = {
    'neovim/nvim-lspconfig',
    name = 'lsp',
    event = 'BufReadPre',
    dependencies = {
        'jose-elias-alvarez/null-ls.nvim',
        'folke/which-key.nvim',
        'hrsh7th/cmp-nvim-lsp',
        'jose-elias-alvarez/typescript.nvim',
        'nvim-lua/lsp-status.nvim',
        'weilbith/nvim-code-action-menu',
        'folke/neodev.nvim',
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
                if vim.lsp.buf.format then
                    vim.lsp.buf.format()
                else
                    vim.lsp.buf.formatting_sync()
                end
            end,
        })
    end
end

function M.config()
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

        require('which-key').register({
            n = {
                name = '+lsp',
                d = { vim.lsp.buf.definition, 'Definition' },
                D = { vim.lsp.buf.declaration, 'Declaration' },
                t = { vim.lsp.buf.type_definition, 'Type definition' },
                i = { vim.lsp.buf.implementation, 'Implementation' },
                r = { vim.lsp.buf.references, 'References' },
                ['[d'] = { vim.lsp.diagnostic.goto_prev, 'Prev diagnostics' },
                [']d'] = { vim.lsp.diagnostic.goto_next, 'Prev diagnostics' },
                a = {
                    name = 'Actions',
                    r = {
                        function()
                            vim.lsp.buf.rename()
                        end,
                        'Rename',
                    },
                    c = {
                        function()
                            require('code_action_menu').open_code_action_menu()
                        end,
                        'Code action',
                    },
                    C = {
                        function()
                            vim.lsp.buf.code_action()
                        end,
                        'Code action',
                    },
                    e = {
                        function()
                            vim.lsp.diagnostic.show_line_diagnostics()
                        end,
                        'Line diagnostics',
                    },
                },
                s = {
                    function()
                        require('telescope.builtin').lsp_document_symbols()
                    end,
                    'Symbols',
                },
                q = {
                    function()
                        vim.lsp.diagnostic.set_loclist()
                    end,
                    'To loclist',
                },
            },
        }, {
            prefix = '<leader>',
            buffer = 0,
        })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true, buffer = 0 })
        vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, { noremap = true, silent = true, buffer = 0 })

        require('lsp-status').on_attach(client)
    end

    local sumneko_root_path = vim.fn.getenv('HOME') .. '/lua-language-server'
    local sumneko_binary = sumneko_root_path .. '/bin/Linux/lua-language-server'

    require('neodev').setup({})

    local servers = {
        eslint = {},
        html = {},
        jsonls = {
            json = { format = { enable = true } },
        },
        rust_analyzer = {},
        sumneko_lua = {
            -- cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
            cmd = { sumneko_binary, '-E' },
        },
        hls = {},
    }

    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    capabilities = vim.tbl_extend('keep', capabilities, require('lsp-status').capabilities)

    local options = { on_attach = on_attach, capabilities = capabilities }

    for server, opts in pairs(servers) do
        opts = vim.tbl_deep_extend('force', {}, options, opts or {})
        require('lspconfig')[server].setup(opts)
    end

    local null_ls = require('null-ls')
    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.stylua.with({
                command = vim.fn.expand('~/.cargo/bin/stylua'),
            }),
            null_ls.builtins.code_actions.eslint,
            null_ls.builtins.diagnostics.eslint,
            null_ls.builtins.formatting.prettier,
        },
        on_attach = on_attach,
    })
    require('typescript').setup({ server = options })
end

return M
