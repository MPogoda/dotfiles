return {
    {
        'ggandor/leap.nvim',
        dependencies = {
            'ggandor/flit.nvim',
            'tpope/vim-repeat',
        },
        config = function()
            require('leap').add_default_mappings()
        end,
        lazy = false,
    },
    {
        'ggandor/flit.nvim',
        config = true,
        lazy = false,
    },
}
