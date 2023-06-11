return {
    'sQVe/bufignore.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        patterns = { '/%.git/', '/%gen/' },
    },
}
