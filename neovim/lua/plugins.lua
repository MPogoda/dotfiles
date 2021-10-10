local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ 'git', 'clone', 'git@github:wbthomason/packer.nvim', install_path })
    vim.api.nvim_command('packadd packer.nvim')
end

vim.api.nvim_exec(
    [[
    augroup Packer
        autocmd!
        autocmd BufWritePost init.lua PackerCompile
        autocmd BufWritePost plugins.lua PackerCompile
    augroup end
    ]],
    false
)

local use = require('packer').use
require('packer').startup(function()
    use('wbthomason/packer.nvim')
    use('lewis6991/impatient.nvim')

    use({
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup()
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
        'sindrets/diffview.nvim',
        cmd = 'DiffviewOpen',
    })

    use({
        'b3nj5m1n/kommentary',
        config = function()
            require('kommentary.config').configure_language('default', {
                prefer_single_line_comments = true,
            })
        end,
    })

    use({
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' },
            { 'gbrlsnchs/telescope-lsp-handlers.nvim' },
            { 'kyazdani42/nvim-web-devicons' },
        },
        config = function()
            require('plugin.telescope')
        end,
    })

    use({
        'Pocco81/Catppuccino.nvim',
        config = function()
            local catppuccino = require('catppuccino')
            catppuccino.setup({
                colorscheme = 'soft_manilo',
                integrations = {
                    lsp_trouble = true,
                    gitsigns = true,
                    telescope = true,
                    which_key = true,
                    indent_blankline = {
                        enabled = true,
                    },
                    lightspeed = true,
                    ts_rainbow = true,
                },
            })
            catppuccino.load()
        end,
    })
    use({
        'hoob3rt/lualine.nvim',
        requires = {
            { 'kyazdani42/nvim-web-devicons' },
            { 'nvim-lua/lsp-status.nvim' },
        },
        config = function()
            require('lualine').setup({
                extensions = {
                    'quickfix',
                    'fugitive',
                },
                sections = {
                    lualine_c = {
                        'filename',
                        require('lsp-status').status
                    },
                },
                theme = 'catppuccino',
            })
        end,
    })

    use({
        'lewis6991/gitsigns.nvim',
        event = 'BufRead',
        requires = { 'nvim-lua/plenary.nvim' },
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
            { 'nvim-treesitter/nvim-treesitter-textobjects' },
            { 'romgrk/nvim-treesitter-context' },
            { 'p00f/nvim-ts-rainbow' },
            { 'windwp/nvim-ts-autotag' },
            { 'lewis6991/spellsitter.nvim' },
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
        }
    })

    use({
        'L3MON4D3/LuaSnip',
        requires = {
            { 'rafamadriz/friendly-snippets', module = { 'luasnip' } },
        },
        config = function()
            require('luasnip.loaders.from_vscode').load({})
        end,
    })
    use({
        'hrsh7th/nvim-cmp',
        requires = {
            { 'L3MON4D3/LuaSnip' },
            { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-calc', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-emoji', after = 'nvim-cmp' },
            { 'f3fora/cmp-spell', after = 'nvim-cmp' },
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
            vim.cmd('ColorizerReloadAllBuffers')
        end,
    })

    use('yamatsum/nvim-cursorline')

    use({
        'lukas-reineke/format.nvim',
        config = function()
            require('plugin.format')
        end,
    })

    use({
        'ggandor/lightspeed.nvim',
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
        config = function()
            vim.cmd(
                [[autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb({virtual_text={enabled = true}})]]
            )
        end,
    })
end)
