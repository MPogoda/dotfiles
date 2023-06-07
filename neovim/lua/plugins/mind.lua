return {
    'phaazon/mind.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'MindOpenMain' },
    config = true,
    keys = {
        {
            '<leader>M',
            function()
                require('mind').open_main()
            end,
            desc = '+MIND',
        },
    },
}
