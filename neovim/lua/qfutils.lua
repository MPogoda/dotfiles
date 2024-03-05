local function find_qf(type)
    local win_tbl = {}
    for _, win in pairs(vim.fn.getwininfo()) do
        local found = false
        if type == 'l' and win['loclist'] == 1 then
            found = true
        end
        if type == 'q' and win['quickfix'] == 1 and win['loclist'] == 0 then
            found = true
        end
        if found then
            table.insert(win_tbl, { winid = win['winid'], bufnr = win['bufnr'] })
        end
    end
    return win_tbl
end

local function open_loclist_all()
    local function qf_empty(winnr)
        return vim.tbl_isempty(vim.fn.getloclist(winnr))
    end

    for _, win in pairs(vim.fn.getwininfo()) do
        if win['quickfix'] == 0 then
            if not qf_empty(win['winnr']) then
                vim.api.nvim_set_current_win(win['winid'])
                vim.cmd('lopen')
            else
                print('loclist is empty')
            end
        end
    end
end

local function open_qf()
    if not vim.tbl_isempty(vim.fn.getqflist()) then
        vim.cmd([[
            copen
            wincmd J
        ]])
    else
        print('quickfix is empty.')
    end
end

local function toggle_qf(type)
    local windows = find_qf(type)
    if #windows > 0 then
        for _, win in pairs(windows) do
            vim.api.nvim_win_hide(win.winid)
        end
    else
        if type == 'l' then
            open_loclist_all()
        else
            open_qf()
        end
    end
end

vim.keymap.set('n', '<leader>q', function()
    toggle_qf('q')
end, { desc = 'quickfix' })
vim.keymap.set('n', '<leader>l', function()
    toggle_qf('l')
end, { desc = 'loclist' })
