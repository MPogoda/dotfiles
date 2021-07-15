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

    use({
        'folke/which-key.nvim',
        config = function()
            require('plugin.whichkey')
        end,
    })
    use({
        'tpope/vim-fugitive',
        config = function()
            require('plugin.fugitive')
        end,
    })
    use('sindrets/diffview.nvim')
    use('tpope/vim-rhubarb')
    use('b3nj5m1n/kommentary')

    use({
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' },
            { 'gbrlsnchs/telescope-lsp-handlers.nvim' },
        },
        config = function()
            require('plugin.telescope')
        end,
    })

    use('sainnhe/sonokai')
    use({
        'Famiu/feline.nvim',
        requires = {
            { 'kyazdani42/nvim-web-devicons' },
            { 'lewis6991/gitsigns.nvim' },
            { 'nvim-lua/lsp-status.nvim' },
        },
        config = function()
            require('feline').setup()
        end,
    })

    use({
        'lewis6991/gitsigns.nvim',
        event = 'BufRead',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('plugin.gitsigns')
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
        config = function()
            require('plugin.treesitter')
        end,
    })
    use({
        'nvim-treesitter/nvim-treesitter-textobjects',
        requires = { 'nvim-treesitter/nvim-treesitter' },
    })
    use({
        'p00f/nvim-ts-rainbow',
        requires = { 'nvim-treesitter/nvim-treesitter' },
    })
    use({
        'windwp/nvim-ts-autotag',
        requires = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('nvim-ts-autotag').setup()
        end,
    })

    use({
        'neovim/nvim-lspconfig',
        requires = {
            { 'ray-x/lsp_signature.nvim' },
        },
        config = function()
            require('plugin.lspconfig')
        end,
    })
    use({
        'hrsh7th/nvim-compe',
        config = function()
            require('plugin.compe')
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

    use({
        'lewis6991/spellsitter.nvim',
        requires = { { 'nvim-treesitter/nvim-treesitter' } },
        config = function()
            require('spellsitter').setup()
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
        'karb94/neoscroll.nvim',
        config = function()
            require('neoscroll').setup()
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
        'junegunn/fzf',
        run = './install --bin',
    })
    use({
        'ibhagwan/fzf-lua',
        requires = {
            'vijaymarupudi/nvim-fzf',
            'kyazdani42/nvim-web-devicons',
        },
        opt = true,
    })
    use({
        'kevinhwang91/nvim-bqf',
        ft = { 'qf' },
        config = function()
            pcall(vim.cmd, 'PackerLoad fzf')
        end,
    })

    use({
        'mhinz/vim-startify',
        config = function()
            require('plugin.startify')
        end
    })
    use('tpope/vim-obsession')

    use('editorconfig/editorconfig-vim')
end)