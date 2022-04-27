-- vim: foldmethod=marker
local lsp_status = require('lsp-status')
lsp_status.register_progress()

require('lsp_signature').setup({
    bind = true,
    toggle_key = '<C-h>',
})

local function on_attach(client, bufnr)
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

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
            w = {
                name = 'workspaces',
                a = { vim.lsp.buf.add_workspace_folder, 'Add workspace' },
                r = { vim.lsp.buf.remove_workspace_folder, 'Remove workspace' },
                l = {
                    function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end,
                    'List workspaces',
                },
            },
            a = {
                name = 'Actions',
                r = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename' },
                c = { '<cmd>CodeActionMenu<cr>', 'Code action' },
                C = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code action' },
                e = { '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', 'Line diagnostics' },
            },
            s = { [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>]], 'Symbols' },
            q = { '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', 'To loclist' },
        },
    }, {
        prefix = '<leader>',
        buffer = bufnr,
    })

    local function map(key, callback)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', key, '', { noremap = true, silent = true, callback = callback })
    end

    map('K', vim.lsp.buf.hover)
    map('<C-h>', vim.lsp.buf.signature_help)

    local group = vim.api.nvim_create_augroup('LspBufFormat', { clear = false })
    vim.api.nvim_clear_autocmds({
        event = 'BufWritePre',
        group = group,
        buffer = bufnr,
    })
    vim.api.nvim_create_autocmd('BufWritePre', {
        group = group,
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.formatting_sync()
        end,
    })

    lsp_status.on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local nvim_lsp = require('lspconfig')

-- {{{ null-ls
local null_ls = require('null-ls')
null_ls.setup({
    sources = {
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettierd,
    },
    on_attach = on_attach,
})
-- }}}

-- {{{ LUA
local sumneko_root_path = vim.fn.getenv('HOME') .. '/lua-language-server'
local sumneko_binary = sumneko_root_path .. '/bin/lua-language-server'

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
table.insert(runtime_path, 'lua/plugin/?.lua')

nvim_lsp.sumneko_lua.setup({
    cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = runtime_path,
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
            },
            telemetry = {
                enable = false,
            },
            completion = { callSnippet = 'Replace' },
        },
    },
})
-- }}}

-- {{{ typescript
nvim_lsp.tsserver.setup({
    capabilities = capabilities,
    init_options = require('nvim-lsp-ts-utils').init_options,
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false

        local ts_utils = require('nvim-lsp-ts-utils')
        ts_utils.setup({
            eslint_enable_disable_comments = false,
            eslint_enable_diagnostics = true,
            eslint_bin = 'eslint_d',
            enable_formatting = true,
            formatter = 'prettierd',
        })
        ts_utils.setup_client(client)
        on_attach(client, bufnr)
    end,
})
-- }}}

-- {{{ rust
nvim_lsp.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})
-- }}}
