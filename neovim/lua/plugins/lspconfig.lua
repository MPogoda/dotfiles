local M = {
    'neovim/nvim-lspconfig',
    name = 'lsp',
    lazy = false,
    dependencies = {
        'saghen/blink.cmp',
        'SmiteshP/nvim-navic',
    },
}

M.opts = {
    html = {},
    jsonls = {},
    rust_analyzer = {},
    lua_ls = {},
    hls = {},
    tsgo = {},
    pylsp = {},
    eslint = {},
}

function M.config(_, opts)
    vim.diagnostic.config({
        severity_sort = true,
    })
    vim.lsp.handlers['workspace/diagnostic/refresh'] = function(_, _, ctx)
        local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
        pcall(vim.diagnostic.reset, ns)
        return true
    end

    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(ev)
            local client = vim.lsp.get_client_by_id(ev.data.client_id)
            if client and client.server_capabilities.documentSymbolProvider then
                require('nvim-navic').attach(client, ev.buf)
            end

            local map = function(key, fn, desc)
                vim.keymap.set('n', key, fn, { desc = desc, buffer = ev.buf, noremap = true, silent = true })
            end
            map('<leader>nd', function()
                require('snacks').picker.lsp_definitions()
            end, 'Definition')
            map('<leader>nD', function()
                require('snacks').picker.lsp_declarations()
            end, 'Declaration')
            map('<leader>nt', function()
                require('snacks').picker.lsp_type_definitions()
            end, 'Type definition')
            map('<leader>ni', function()
                require('snacks').picker.lsp_implementations()
            end, 'Implementation')
            map('<leader>nr', function()
                require('snacks').picker.lsp_references()
            end, 'References')
        end,
    })

    local capabilities = require('blink.cmp').get_lsp_capabilities()

    for server, config in pairs(opts) do
        config = vim.tbl_deep_extend('force', {}, { capabilities = capabilities }, config or {})
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
    end

    vim.api.nvim_create_autocmd('LspProgress', {
        group = vim.api.nvim_create_augroup('lsp-progress-ghostty', { clear = true }),
        callback = function(ev)
            local value = ev.data.params.value or {}
            local msg = value.message or 'done'

            -- :h LspProgress
            vim.api.nvim_echo({ { msg } }, false, {
                id = 'lsp' .. ev.data.params.token,
                kind = 'progress',
                title = value.title,
                source = 'vim.lsp',
                status = value.kind ~= 'end' and 'running' or 'success',
                percent = value.percentage,
            })
        end,
    })
end

return M
