local M = {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    dependencies = {
        'andersevenrud/nvim_context_vt',
    },
}
function M.config()
    local languages = {
        'typescript',
        'tsx',
        'javascript',
        'jsdoc',
        'lua',
        'luadoc',
        'luap',
        'python',
        'rust',
        'html',
        'css',
        'json',
        'yaml',
        'toml',
        'bash',
        'diff',
        'regex',
        'query',
        'markdown',
        'markdown_inline',
        'vim',
        'vimdoc',
        'gitcommit',
        'git_rebase',
        'gitignore',
        'dockerfile',
        'haskell',
    }

    require('nvim-treesitter').install(languages)
    vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('treesitter-extra', { clear = true }),
        pattern = languages,
        callback = function()
            vim.treesitter.start()
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo.foldmethod = 'expr'
            vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
        end,
    })
end

return M
