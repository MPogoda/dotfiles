local M = {
    'saghen/blink.cmp',
    dependencies = {
        'rafamadriz/friendly-snippets',
        'folke/lazydev.nvim',
        'moyiz/blink-emoji.nvim',
    },
    version = '*',
    event = { 'InsertEnter', 'CmdlineEnter' },
    opts = {
        keymap = {
            preset = 'default',
            ['<C-k>'] = { 'fallback' },
            ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
            },
            ghost_text = { enabled = true },
        },
        cmdline = {
            completion = {
                menu = {
                    auto_show = function(ctx)
                        return ctx.mode == 'cmdline'
                    end,
                },
            },
        },
        appearance = {
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
        signature = {
            enabled = true,
            trigger = {
                show_on_accept = true,
            },
        },
    },
}

return M
