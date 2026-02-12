if not vim.g.neovide then
    return
end

vim.o.guifont = 'Iosevka SS09,Hack Nerd Font:h13'
vim.o.linespace = -3
vim.g.neovide_hide_mouse_while_typing = true
vim.g.neovide_cursor_vfx_mode = 'railgun'
vim.g.neovide_fullscreen = true

vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
vim.keymap.set('v', '<D-c>', '"+y') -- Copy
vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
vim.keymap.set('t', '<D-v>', '<C-R>+') -- Paste terminal mode
