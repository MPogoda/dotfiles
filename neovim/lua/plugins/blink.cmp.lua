local M = {
    'saghen/blink.cmp',
    enabled = false,
    dependencies = {
        'rafamadriz/friendly-snippets',
        'folke/lazydev.nvim',
        'moyiz/blink-emoji.nvim',
    },
    version = '*',
    event = 'InsertEnter',
    opts = {
        keymap = { preset = 'super-tab' },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
            },
            ghost_text = { enabled = true },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono',
        },
        sources = {
            default = {
                'lazydev',
                'lsp',
                'path',
                'snippets',
                'buffer',
                'emoji',
            },
            providers = {
                lazydev = {
                    name = 'LazyDev',
                    module = 'lazydev.integrations.blink',
                    score_offset = 100,
                },
                emoji = {
                    name = 'Emoji',
                    module = 'blink-emoji',
                    score_offset = 15,
                },
            },
        },
        signature = { enabled = true },
    },
}

return M
