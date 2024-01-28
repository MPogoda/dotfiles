return {
    'kdheepak/lazygit.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    keys = {
        {
            '<leader>gl',
            function()
                require('lazygit').lazygit()
            end,
            desc = 'lazygit',
            noremap = true,
        },
    },
}
