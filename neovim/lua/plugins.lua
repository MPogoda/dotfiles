local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ 'git', 'clone', 'github.com:wbthomason/packer.nvim', install_path })
    -- vim.api.nvim_command('packadd packer.nvim')
end

local packerGroup = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    group = packerGroup,
    pattern = { 'init.lua', 'plugins.lua' },
    command = 'source <afile> | PackerCompile',
})

local use = require('packer').use
require('packer').startup({
    function()
        use('wbthomason/packer.nvim')
        use('lewis6991/impatient.nvim')

        use({
            'folke/which-key.nvim',
            config = function()
                require('which-key').setup({
                    plugins = { spelling = { enabled = true } },
                    window = { position = 'top' },
                })
            end,
        })

        use({
            'tpope/vim-fugitive',
            requires = {
                { 'tpope/vim-rhubarb' },
            },
            config = function()
                require('plugin.fugitive')
            end,
        })

        use({
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup({
                    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
                })
            end,
            requires = {
                { 'JoosepAlviste/nvim-ts-context-commentstring' },
            },
        })

        use({
            'nvim-telescope/telescope.nvim',
            requires = {
                { 'nvim-lua/plenary.nvim' },
                { 'gbrlsnchs/telescope-lsp-handlers.nvim' },
                { 'kyazdani42/nvim-web-devicons' },
            },
            config = function()
                require('plugin.telescope')
            end,
        })

        use({
            'catppuccin/nvim',
            config = function()
                local catppuccin = require('catppuccin')
                catppuccin.setup({
                    dim_inactive = { enabled = true },
                    compile = { enabled = true },
                    integrations = {
                        lsp_trouble = true,
                        which_key = true,
                        ts_rainbow = true,
                        leap = true,
                    },
                })
                catppuccin.load()
            end,
        })

        use({
            'nvim-lualine/lualine.nvim',
            requires = {
                { 'kyazdani42/nvim-web-devicons' },
                { 'nvim-lua/lsp-status.nvim' },
                { 'catppuccin/nvim' },
            },
            config = function()
                require('lualine').setup({
                    options = { globalstatus = true },
                    extensions = { 'quickfix', 'fugitive' },
                    sections = {
                        lualine_c = {
                            'filename',
                            [[require('lsp-status').status()]],
                        },
                    },
                    theme = 'catppuccin',
                })
            end,
        })

        use({
            'lewis6991/gitsigns.nvim',
            event = 'BufRead',
            config = function()
                require('plugin.git-signs')
            end,
        })
        use({
            'lukas-reineke/indent-blankline.nvim',
            event = 'BufRead',
            config = function()
                require('plugin.indent-blankline')
            end,
        })
        use({
            'nvim-treesitter/nvim-treesitter',
            requires = {
                { 'romgrk/nvim-treesitter-context' },
                { 'p00f/nvim-ts-rainbow' },
                { 'windwp/nvim-ts-autotag' },
                { 'lewis6991/spellsitter.nvim' },
                { 'JoosepAlviste/nvim-ts-context-commentstring' },
                { 'haringsrob/nvim_context_vt' },
            },
            config = function()
                require('plugin.treesitter')
                require('treesitter-context').setup()
                require('nvim-ts-autotag').setup()
                require('spellsitter').setup()
            end,
        })

        use({
            'neovim/nvim-lspconfig',
            requires = {
                { 'ray-x/lsp_signature.nvim' },
                { 'jose-elias-alvarez/null-ls.nvim' },
                { 'hrsh7th/cmp-nvim-lsp' },
            },
            config = function()
                require('plugin.lspconfig')
            end,
        })
        use({
            'jose-elias-alvarez/nvim-lsp-ts-utils',
            requires = {
                { 'neovim/nvim-lspconfig' },
                { 'nvim-lua/plenary.nvim' },
                { 'jose-elias-alvarez/null-ls.nvim' },
            },
        })

        use({
            'L3MON4D3/LuaSnip',
            requires = {
                { 'rafamadriz/friendly-snippets', module = { 'luasnip' } },
            },
            config = function()
                require('luasnip.loaders.from_vscode').lazy_load()
                local l = require('luasnip')

                vim.keymap.set({ 'i', 's' }, '<c-e>', function()
                    if not l.choice_active() then
                        return '<c-e>'
                    end
                    vim.schedule(function()
                        l.change_choice(1)
                    end)
                    return '<Ignore>'
                end, {
                    expr = true,
                    silent = true,
                    noremap = true,
                })
                -- Jump forward or backward
                vim.keymap.set('i', '<tab>', function()
                    if not l.expand_or_jumpable() then
                        return '<tab>'
                    end
                    vim.schedule(l.expand_or_jump)
                    return '<Ignore>'
                end, {
                    expr = true,
                    silent = true,
                })

                vim.keymap.set({ 'i', 's' }, '<s-tab>', function()
                    l.jump(-1)
                end, {
                    silent = true,
                    noremap = true,
                })

                vim.keymap.set('s', '<tab>', function()
                    l.jump(1)
                end, {
                    noremap = true,
                    silent = true,
                })
            end,
        })
        use({
            'hrsh7th/nvim-cmp',
            requires = {
                { 'L3MON4D3/LuaSnip' },
                { 'saadparwaiz1/cmp_luasnip' },
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'hrsh7th/cmp-path' },
                { 'hrsh7th/cmp-buffer' },
                { 'hrsh7th/cmp-calc' },
                { 'hrsh7th/cmp-emoji' },
                { 'f3fora/cmp-spell' },
                { 'onsails/lspkind-nvim' },
            },
            config = function()
                require('plugin.completion')
            end,
        })

        use({
            'folke/trouble.nvim',
            requires = {
                { 'kyazdani42/nvim-web-devicons' },
                { 'folke/lsp-colors.nvim' },
            },
            config = function()
                require('plugin.trouble')
            end,
        })

        use({
            'norcalli/nvim-colorizer.lua',
            event = 'BufRead',
            config = function()
                require('colorizer').setup()
            end,
        })

        use({
            'yamatsum/nvim-cursorline',
            config = function()
                require('nvim-cursorline').setup({})
            end,
        })

        use({
            'ggandor/leap.nvim',
            config = function()
                require('leap').set_default_keymaps()
            end,
        })

        use({
            'simnalamburt/vim-mundo',
            config = function()
                require('plugin.mundo')
            end,
        })

        use('tpope/vim-surround')
        use('tpope/vim-repeat')

        use({
            'kevinhwang91/nvim-bqf',
            ft = { 'qf' },
        })

        use({
            'mhinz/vim-startify',
            config = function()
                require('plugin.startify')
            end,
        })
        use('tpope/vim-obsession')

        use('editorconfig/editorconfig-vim')
        use({
            'weilbith/nvim-code-action-menu',
            cmd = 'CodeActionMenu',
        })

        use({
            'kosayoda/nvim-lightbulb',
            requires = { 'antoinemadec/FixCursorHold.nvim' },
            config = function()
                require('nvim-lightbulb').setup({
                    virtual_text = { enabled = true },
                })
            end,
        })

        use({
            'luukvbaal/stabilize.nvim',
            config = function()
                require('stabilize').setup()
            end,
        })

        use('stevearc/dressing.nvim')

        use({
            'petertriho/nvim-scrollbar',
            config = function()
                require('scrollbar').setup()
            end,
        })

        use({
            'anuvyklack/pretty-fold.nvim',
            config = function()
                require('pretty-fold').setup({})
            end,
        })

        use({
            'anuvyklack/fold-preview.nvim',
            requires = { 'anuvyklack/keymap-amend.nvim' },
            config = function()
                require('fold-preview').setup({})
            end,
        })

        use({
            'akinsho/git-conflict.nvim',
            tag = '*',
            config = function()
                require('git-conflict').setup()
            end,
        })
    end,
    config = {
        compile_path = vim.fn.stdpath('config') .. '/lua/packer_compiled.lua',
    },
})

require('packer_compiled')
