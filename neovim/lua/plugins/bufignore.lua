return {
    'sQVe/bufignore.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = false,
    opts = {
        patterns = { '/%.git/', '/%gen/' },
    },
}
