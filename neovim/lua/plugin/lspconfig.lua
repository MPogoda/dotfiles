-- vim: foldmethod=marker
local lsp_status = require('lsp-status')
lsp_status.register_progress()

require('lsp_signature').setup({
    bind = true,
    toggle_key = '<C-h>'
})

local function on_attach(client, bufnr)
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    require('which-key').register({
        n = {
            name = '+lsp',
            d = { '<cmd>lua vim.lsp.buf.definition()<cr>', 'Definition' },
            D = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Declaration' },
            t = { '<cmd>lua vim.lsp.buf.type_definition()<cr>', 'Type definition' },
            i = { '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Implementation' },
            r = { '<cmd>lua vim.lsp.buf.references()<cr>', 'References' },
            ['[d'] = { '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', 'Prev diagnostics' },
            [']d'] = { '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', 'Prev diagnostics' },
            w = {
                name = 'workspaces',
                a = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', 'Add workspace' },
                r = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', 'Remove workspace' },
                l = { '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', 'List workspaces' },
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

    local function map(key, action)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', key, action, { noremap = true, silent = true })
    end

    map('K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    map('<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

    lsp_status.on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities);

local nvim_lsp = require('lspconfig')

local null_ls = require('null-ls')
null_ls.config({
    sources = {
        null_ls.builtins.formatting.stylua
    }
})
nvim_lsp["null-ls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- {{{ LUA
local sumneko_root_path = vim.fn.getenv('HOME') .. '/lua-language-server'
local sumneko_binary = sumneko_root_path .. '/bin/macOs/lua-language-server'

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
        },
    },
})
-- }}}
-- {{{ typescript
nvim_lsp.tsserver.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false

        local ts_utils = require('nvim-lsp-ts-utils')
        ts_utils.setup({
            eslint_enable_diagnostics = true,
            eslint_bin = 'eslint_d',
            enable_formatting = true,
            formatter = 'prettierd',
        })
        ts_utils.setup_client(client)
        on_attach(client, bufnr)

        vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
    end,
})
-- }}}
