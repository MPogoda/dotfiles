local M = {
    'folke/trouble.nvim',
    cmd = { 'Trouble', 'TroubleToggle' },
    dependencies = {
        'kyazdani42/nvim-web-devicons',
        'folke/lsp-colors.nvim',
    },
}

function M.config()
    require('trouble').setup({
        auto_close = true,
        use_diagnostic_signs = true,
    })
end

function M.init()
    require('which-key').register({
        x = { '<cmd>TroubleToggle<cr>', 'Troubles?' },
    }, { prefix = '<leader>' })
end

return M
