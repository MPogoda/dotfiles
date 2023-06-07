return {
    'mhinz/vim-startify',
    config = function()
        vim.g.startify_session_autoload = true
        vim.g.startify_fortune_use_unicode = true
        vim.g.startify_change_to_dir = false
    end,
    lazy = false,
}
