return {
    'goolord/alpha-nvim',
    dependencies = { 'echasnovski/mini.icons' },
    opts = function()
        return require('alpha.themes.startify').config
    end,
    lazy = false,
}
