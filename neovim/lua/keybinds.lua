require('which-key').register({
    ['$'] = { "<cmd>execute 'bnext<bar>bdelete' bufnr('%')<cr>", 'Close current buffer' },
    e = { '<cmd>edit!<cr>', 'Reload' },
    w = { '<cmd>write<cr>', 'Save' },
    t = {
        name = '+toggle',
        s = {
            function()
                vim.wo.spell = not vim.wo.spell
            end,
            'Spell?',
        },
    },
}, {
    prefix = '<leader>',
})

vim.keymap.set('n', 'Y', 'y$', { noremap = true })

vim.keymap.set('i', 'jj', '<esc>', { silent = true, noremap = true })
vim.keymap.set('c', 'jj', '<esc>', {})

vim.keymap.set('n', '<c-l>', ':<c-u>nohlsearch<cr>', { noremap = true })

vim.keymap.set('n', 'gv', '`[v`]', { noremap = true }) -- last edited or pasted

vim.keymap.set('v', '>', '>gv', { noremap = true })
vim.keymap.set('v', '<', '<gv', { noremap = true })

local id
for _, key in ipairs({ 'h', 'j', 'k', 'l' }) do
    local count = 0
    vim.keymap.set('n', key, function()
        if count >= 10 then
            id = vim.notify('Hold it Cowboy!', vim.log.levels.WARN, {
                icon = '🤠',
                replace = id,
                keep = function()
                    return count >= 10
                end,
            })
        else
            count = count + 1
            vim.defer_fn(function()
                count = count - 1
            end, 5000)
            return key
        end
    end, {
        expr = true,
    })
end

-- Move to window using the <ctrl> movement keys
vim.keymap.set('n', '<left>', '<C-w>h')
vim.keymap.set('n', '<down>', '<C-w>j')
vim.keymap.set('n', '<up>', '<C-w>k')
vim.keymap.set('n', '<right>', '<C-w>l')
-- Resize window using <ctrl> arrow keys
vim.keymap.set('n', '<S-Up>', '<cmd>resize +2<CR>')
vim.keymap.set('n', '<S-Down>', '<cmd>resize -2<CR>')
vim.keymap.set('n', '<S-Left>', '<cmd>vertical resize -2<CR>')
vim.keymap.set('n', '<S-Right>', '<cmd>vertical resize +2<CR>')

vim.keymap.set('n', '<C-Left>', '<cmd>bprevious<cr>')
vim.keymap.set('n', '<C-Right>', '<cmd>bnext<cr>')

vim.keymap.set({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>')
