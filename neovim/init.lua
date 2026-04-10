-- vim: foldmethod=marker
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.termguicolors = true

vim.opt.runtimepath:prepend('/usr/share/vim/vimfiles')
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

vim.opt.diffopt:append('vertical')
vim.opt.diffopt:append('indent-heuristic')

vim.opt.foldminlines = 5
vim.opt.foldlevelstart = 2

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

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight on yank!',
    group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd('TermOpen', {
    desc = 'Make terminals better',
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end,
})

vim.opt.timeoutlen = 500

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

local install_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(install_path) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        install_path,
    })
end
vim.opt.runtimepath:prepend(install_path)

require('lazy').setup('plugins', {
    lazy = true,
    rocks = { enabled = false },
})

require('keybinds')
require('qfutils')
local ui2 = require('vim._core.ui2')
ui2.enable({
    enable = true,
    msg = {
        targets = {
            [''] = 'msg',
            empty = 'cmd',
            bufwrite = 'msg',
            confirm = 'cmd',
            emsg = 'pager',
            echo = 'msg',
            echomsg = 'msg',
            echoerr = 'pager',
            completion = 'cmd',
            list_cmd = 'pager',
            lua_error = 'pager',
            lua_print = 'msg',
            progress = 'pager',
            rpc_error = 'pager',
            quickfix = 'msg',
            search_cmd = 'cmd',
            search_count = 'cmd',
            shell_cmd = 'pager',
            shell_err = 'pager',
            shell_out = 'pager',
            shell_ret = 'msg',
            undo = 'msg',
            verbose = 'pager',
            wildlist = 'cmd',
            wmsg = 'msg',
            typed_cmd = 'cmd',
        },
        cmd = { height = 0.5 },
        dialog = { height = 0.5 },
        msg = { height = 0.3, timeout = 5000 },
        pager = { height = 0.5 },
    },
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'msg',
    callback = function()
        local win = ui2.wins and ui2.wins.msg
        if win and vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_set_option_value(
                'winhighlight',
                'Normal:NormalFloat,FloatBorder:FloatBorder',
                { scope = 'local', win = win }
            )
        end
    end,
})

local msgs = require('vim._core.ui2.messages')
local orig_set_pos = msgs.set_pos
msgs.set_pos = function(tgt)
    orig_set_pos(tgt)
    if (tgt == 'msg' or tgt == nil) and vim.api.nvim_win_is_valid(ui2.wins.msg) then
        pcall(vim.api.nvim_win_set_config, ui2.wins.msg, {
            relative = 'editor',
            anchor = 'NE',
            row = 1,
            col = vim.o.columns - 1,
            border = 'rounded',
        })
    end
end

vim.lsp.document_color.enable(true, nil, { style = 'virtual' })
