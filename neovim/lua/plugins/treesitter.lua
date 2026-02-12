local M = {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufReadPost',
    dependencies = {
        'andersevenrud/nvim_context_vt',
    },
}
function M.config()
    require('nvim-treesitter.configs').setup({
        ensure_installed = {
            'typescript', 'tsx', 'javascript', 'jsdoc',
            'lua', 'luadoc', 'luap',
            'python',
            'rust',
            'html', 'css', 'json', 'jsonc', 'yaml', 'toml',
            'bash', 'diff', 'regex', 'query',
            'markdown', 'markdown_inline',
            'vim', 'vimdoc',
            'gitcommit', 'git_rebase', 'gitignore',
            'dockerfile', 'haskell',
        },
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
    })
end

return M
