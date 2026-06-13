-- Monaspace multi-font: italic/bold attributes trigger different font variants
-- via Ghostty's font-family-italic / font-family-bold / font-family-bold-italic
vim.api.nvim_create_autocmd('ColorScheme', {
    desc = 'Monaspace: map syntax groups to font variants',
    group = vim.api.nvim_create_augroup('MonaspaceFonts', { clear = true }),
    callback = function()
        local set = vim.api.nvim_set_hl

        -- Comments → italic → Monaspace Radon (handwriting)
        set(0, 'Comment', { italic = true, fg = vim.api.nvim_get_hl(0, { name = 'Comment' }).fg })
        set(0, '@comment', { link = 'Comment' })

        -- Keywords → bold → Monaspace Xenon (slab serif)
        set(0, 'Keyword', { bold = true, fg = vim.api.nvim_get_hl(0, { name = 'Keyword' }).fg })
        set(0, '@keyword', { link = 'Keyword' })
        set(0, '@keyword.function', { link = 'Keyword' })
        set(0, '@keyword.return', { link = 'Keyword' })
        set(0, '@keyword.operator', { link = 'Keyword' })
        set(0, 'Conditional', { bold = true, fg = vim.api.nvim_get_hl(0, { name = 'Conditional' }).fg })
        set(0, 'Repeat', { bold = true, fg = vim.api.nvim_get_hl(0, { name = 'Repeat' }).fg })

        -- Types → bold → Monaspace Xenon
        set(0, 'Type', { bold = true, fg = vim.api.nvim_get_hl(0, { name = 'Type' }).fg })
        set(0, '@type', { link = 'Type' })
        set(0, '@type.builtin', { link = 'Type' })

        -- Strings → italic → Monaspace Radon
        set(0, 'String', { italic = true, fg = vim.api.nvim_get_hl(0, { name = 'String' }).fg })
        set(0, '@string', { link = 'String' })

        -- Diagnostics → bold+italic → Monaspace Krypton (mechanical)
        set(
            0,
            'DiagnosticError',
            { bold = true, italic = true, fg = vim.api.nvim_get_hl(0, { name = 'DiagnosticError' }).fg }
        )
        set(
            0,
            'DiagnosticWarn',
            { bold = true, italic = true, fg = vim.api.nvim_get_hl(0, { name = 'DiagnosticWarn' }).fg }
        )
    end,
})
-- Trigger for the current colorscheme
vim.cmd.doautocmd('ColorScheme')
