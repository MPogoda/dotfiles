return {
    'ggandor/leap.nvim',
    dependencies = {
        'ggandor/flit.nvim',
        'tpope/vim-repeat',
    },
    config = function()
        require('leap').add_default_mappings()
        require('flit').setup()
    end,
    lazy = false,
}
