local M = {
    'L3MON4D3/LuaSnip',
    event = 'BufReadPost',
    dependencies = {
        {
            'rafamadriz/friendly-snippets',
            config = function()
                require('luasnip.loaders.from_vscode').lazy_load()
            end,
        },
    },
    build = 'make install_jsregexp',
}
function M.config()
    local l = require('luasnip')

    vim.keymap.set({ 'i', 's' }, '<c-e>', function()
        if not l.choice_active() then
            return '<c-e>'
        end
        vim.schedule(function()
            l.change_choice(1)
        end)
        return '<Ignore>'
    end, { expr = true, silent = true, noremap = true })
    -- Jump forward or backward
    vim.keymap.set('i', '<tab>', function()
        if not l.expand_or_jumpable() then
            return '<tab>'
        end
        vim.schedule(l.expand_or_jump)
        return '<Ignore>'
    end, { expr = true, silent = true })

    vim.keymap.set({ 'i', 's' }, '<s-tab>', function()
        l.jump(-1)
    end, { silent = true, noremap = true })

    vim.keymap.set('s', '<tab>', function()
        l.jump(1)
    end, { noremap = true, silent = true })
end

return M
