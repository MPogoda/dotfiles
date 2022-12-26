local M = {
    'phaazon/mind.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'MindOpenMain' },
    config = function()
        require('mind').setup()
    end,
}

function M.init()
    vim.keymap.set('n', '<leader>M', require('mind').open_main, { desc = '+MIND' })
end

return M
