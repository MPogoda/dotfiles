-- vim: foldmethod=marker
require('impatient')

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

vim.opt.termguicolors = true

require('plugins')
require('keybinds')
require('qfutils')

vim.opt.runtimepath:prepend('/usr/share/vim/vimfiles')

vim.opt.hidden = true
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

vim.opt.diffopt:append('vertical')
vim.opt.diffopt:append('indent-heuristic')

vim.opt.foldmethod = 'indent'

vim.opt.formatoptions:append('n') -- recognise numbered lists
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.grepprg = 'rg --vimgrep --no-heading'
vim.opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
vim.opt.colorcolumn = '+1' -- show line after textwidth

vim.opt.scrolloff = 3 -- context lines around cursor

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.cursorline = true -- highlight currently focused line
vim.opt.relativenumber = true

vim.opt.wildignore = { '.git' }
vim.opt.wildmode:prepend('list:longest')
vim.opt.list = true
vim.opt.listchars = {
    tab = '→ ',
    extends = '❯',
    precedes = '❮',
    nbsp = '␣',
}
vim.opt.showbreak = '↪'
vim.opt.showmode = false
vim.opt.shortmess:append('c') -- don't give ins-completion-menu messages

-- focus new window after splitting
vim.opt.splitright = true
vim.opt.splitbelow = true

local yhGroup = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    group = yhGroup,
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.opt.timeoutlen = 500
