return {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    version = '*',
    event = 'BufReadPre',
    dependencies = {
        'SmiteshP/nvim-navic',
        'nvim-tree/nvim-web-devicons',
    },
    opts = {
        theme = 'catppuccin'
    }
}
