require('compe').setup({
    source = {
        path = true,
        nvim_lsp = true,
        luasnip = true,
        buffer = false,
        calc = true,
        nvim_lua = false,
        vsnip = false,
        ultisnips = false,
    },
})

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t('<C-n>')
    elseif check_back_space() then
        return t('<Tab>')
    else
        return vim.fn['compe#complete']()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t('<C-p>')
    else
        return t('<S-Tab>')
    end
end

local function map(mode, key, action)
    vim.api.nvim_set_keymap(mode, key, action, { expr = true })
end
-- Map tab to the above tab complete functiones
map('i', '<Tab>', 'v:lua.tab_complete()')
map('s', '<Tab>', 'v:lua.tab_complete()')
map('i', '<S-Tab>', 'v:lua.s_tab_complete()')
map('s', '<S-Tab>', 'v:lua.s_tab_complete()')

-- Map compe confirm and complete functions
map('i', '<cr>', 'compe#confirm("<cr>")')
map('i', '<c-space>', 'compe#complete()')
