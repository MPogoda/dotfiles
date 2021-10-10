require('format').setup({
    ['*'] = {
        { cmd = { [[sed -i 's/[ \t]*$//']] } },
    },
})

vim.api.nvim_exec(
    [[
    augroup Format
        autocmd!
        autocmd BufWritePost * FormatWrite
    augroup end
]],
    false
)
