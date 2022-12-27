return {
    'kosayoda/nvim-lightbulb',
    dependencies = { 'antoinemadec/FixCursorHold.nvim' },
    config = function()
        require('nvim-lightbulb').setup({
            virtual_text = { enabled = true },
        })
    end,
}
