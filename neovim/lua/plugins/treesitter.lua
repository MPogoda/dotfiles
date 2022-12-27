local M = {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufReadPost',
    dependencies = {
        'p00f/nvim-ts-rainbow',
        'JoosepAlviste/nvim-ts-context-commentstring',
        'haringsrob/nvim_context_vt',
    },
}
function M.config()
    require('nvim-treesitter.configs').setup({
        ensure_installed = 'all',
        highlight = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = 'gnn',
                node_incremental = 'grn',
                scope_incremental = 'grc',
                node_decremental = 'grm',
            },
        },
        indent = { enable = true },
        rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = 1000,
        },
        context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },
    })
end

return M
