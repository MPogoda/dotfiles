return {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'BufReadPre',
    opts = {
        exclude = {
            filetypes = { 'help', 'packer', 'startify', 'Trouble' },
            buftypes = { 'terminal', 'nofile' },
        },
    },
}
