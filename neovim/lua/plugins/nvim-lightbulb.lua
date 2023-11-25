return {
    'kosayoda/nvim-lightbulb',
    event = 'BufReadPost',
    opts = {
        virtual_text = { enabled = true },
        status_text = { enabled = true },
        autocmd = { enabled = true },
    },
}
