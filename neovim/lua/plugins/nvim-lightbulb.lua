return {
    'kosayoda/nvim-lightbulb',
    dependencies = { 'antoinemadec/FixCursorHold.nvim' },
    event = 'BufReadPost',
    opts = {
        virtual_text = { enabled = true },
        status_text = { enabled = true },
        autocmd = { enabled = true },
    },
}
