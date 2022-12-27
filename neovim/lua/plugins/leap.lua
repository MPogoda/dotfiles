local M = {
    'ggandor/leap.nvim',
    dependencies = {
        'ggandor/flit.nvim',
    },
    config = function()
        require('leap').add_default_mappings()
        require('flit').setup()
    end,
}
return M
