return {
    'akinsho/git-conflict.nvim',
    tag = '*',
    config = function()
        require('git-conflict').setup()
    end,
}
