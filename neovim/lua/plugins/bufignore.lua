return {
    'sQVe/bufignore.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = false,
    opts = {
        ignore_sources = {
            patterns = { '/%.git/', '/%gen/' },
        },
    },
}
