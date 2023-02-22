return {
    'kosayoda/nvim-lightbulb',
    dependencies = { 'antoinemadec/FixCursorHold.nvim' },
    config = function()
        require('nvim-lightbulb').setup({
            virtual_text = { enabled = true },
            status_text = { enabled = true },
            autocmd = { enabled = true },
        })
    end,
}
