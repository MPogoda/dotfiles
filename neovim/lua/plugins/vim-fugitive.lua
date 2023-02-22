local M = {
    'tpope/vim-fugitive',
    dependencies = {
        'folke/which-key.nvim',
        'tpope/vim-rhubarb',
    },
}

function M.config()
    require('which-key').register({
        g = {
            name = '+git',
            s = { '<cmd>Git<cr>', 'Status' },
            c = { '<cmd>Git commit --no-verify<cr>', 'Commit [no verify]' },
            w = { '<cmd>Gwrite<cr>', 'Stage' },
            b = { '<cmd>Git blame<cr>', 'Blame' },
            d = { '<cmd>Gdiffsplit<cr>', 'Diff' },
            o = { '<cmd>GBrowse<cr>', 'Open in …' },
        },
    }, { prefix = '<leader>' })

    require('which-key').register({
        g = {
            name = '+git',
            o = { [[<cmd>'<,'>GBrowse<cr>]], 'Open in …' },
        },
    }, { prefix = '<leader>', mode = 'v' })
end

return M
