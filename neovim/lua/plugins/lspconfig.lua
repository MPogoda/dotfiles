local M = {
    'neovim/nvim-lspconfig',
    name = 'lsp',
    lazy = false,
    dependencies = {
        'folke/which-key.nvim',
        'saghen/blink.cmp',
        'SmiteshP/nvim-navic',
    },
}

M.opts = {
    html = {},
    jsonls = {
        json = { format = { enable = true } },
    },
    rust_analyzer = {},
    lua_ls = {},
    hls = {},
    ts_ls = {},
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

    local function on_attach(client, bufNr)
        if client.server_capabilities.documentSymbolProvider then
            require('nvim-navic').attach(client, bufNr)
        end

        vim.keymap.set('n', '<leader>nd', function()
            require('snacks').picker.lsp_definitions()
        end, { desc = 'Definition', buffer = bufNr, noremap = true, silent = true })
        vim.keymap.set('n', '<leader>nD', function()
            require('snacks').picker.lsp_declarations()
        end, { desc = 'Declaration', buffer = bufNr, noremap = true, silent = true })
        vim.keymap.set('n', '<leader>nt', function()
            require('snacks').picker.lsp_type_definitions()
        end, { desc = 'Type definition', buffer = bufNr, noremap = true, silent = true })
        vim.keymap.set('n', '<leader>ni', function()
            require('snacks').picker.lsp_implementations()
        end, { desc = 'Implementation', buffer = bufNr, noremap = true, silent = true })
        vim.keymap.set('n', '<leader>nr', function()
            require('snacks').picker.lsp_references()
        end, { desc = 'References', buffer = bufNr, noremap = true, silent = true })
    end

    local capabilities = require('blink.cmp').get_lsp_capabilities()

    local options = { on_attach = on_attach, capabilities = capabilities }

    for server, config in pairs(opts) do
        config = vim.tbl_deep_extend('force', {}, options, config or {})
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
