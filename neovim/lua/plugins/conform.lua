return {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    opts = {
        formatters_by_ft = {
            javascript = { 'prettierd' },
            typescript = { 'prettierd' },
            javascriptreact = { 'prettierd' },
            typescriptreact = { 'prettierd' },
            json = { 'prettierd' },
            html = { 'prettierd' },
            css = { 'prettierd' },
            yaml = { 'prettierd' },
            markdown = { 'prettierd' },
            lua = { 'stylua' },
        },
        format_on_save = {
            timeout_ms = 2000,
            lsp_format = 'fallback',
        },
    },
}
