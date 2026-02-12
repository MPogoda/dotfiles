local M = {
    'nvim-telescope/telescope.nvim',
    cmd = { 'Telescope' },
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'gbrlsnchs/telescope-lsp-handlers.nvim',
        'nvim-tree/nvim-web-devicons',
    },
}

function M.config()
    local telescope = require('telescope')

    telescope.setup({
        extensions = { fzf = {} },
        pickers = {
            find_files = { theme = 'ivy' },
            diagnostics = { theme = 'ivy' },
            oldfiles = { theme = 'ivy' },
        },
        defaults = {
            mappings = {
                i = {
                    ['<c-u>'] = false,
                    ['<c-d>'] = false,
                    ['jj'] = require('telescope.actions').close,
                    ['<esc>'] = require('telescope.actions').close,
                    ['<c-down>'] = require('telescope.actions').cycle_history_next,
                    ['<c-up>'] = require('telescope.actions').cycle_history_prev,
                },
            },
        },
    })

    telescope.load_extension('lsp_handlers')
    telescope.load_extension('fzf')
end

local live_multigrep = function(opts)
    opts = opts or {}
    opts.cwd = opts.cwd or vim.uv.cwd()

    local finder = require('telescope.finders').new_async_job({
        command_generator = function(prompt)
            if not prompt or prompt == '' then
                return nil
            end

            local pieces = vim.split(prompt, '  ')
            local args = { 'rg' }
            if pieces[1] then
                table.insert(args, '-e')
                table.insert(args, pieces[1])
            end

            if pieces[2] then
                table.insert(args, '-g')
                table.insert(args, pieces[2])
            end

            return vim.iter({
                args,
                { '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' },
            }):flatten():totable()
        end,
        entry_maker = require('telescope.make_entry').gen_from_vimgrep(opts),
        cwd = opts.cwd,
    })

    require('telescope.pickers')
        .new(opts, {
            debounce = 100,
            prompt_title = 'Multi Grep',
            finder = finder,
            previewer = require('telescope.config').values.grep_previewer(opts),
            sorter = require('telescope.sorters').empty(),
        })
        :find()
end

M.keys = {
    {
        '<leader>fb',
        function()
            require('telescope.builtin').buffers({ theme = 'get_dropdown' })
        end,
        desc = 'Buffers',
    },
    {
        '<leader>ff',
        function()
            require('telescope.builtin').find_files()
        end,
        desc = 'Files',
    },
    {
        '<leader>fG',
        function()
            require('telescope.builtin').git_status()
        end,
        desc = 'Git status',
    },
    { '<leader>fg', live_multigrep, desc = 'Live Multigrep' },
    {
        '<leader>fo',
        function()
            require('telescope.builtin').oldfiles({ theme = 'ivy' })
        end,
        desc = 'Oldfiles',
    },
    {
        '<leader>f/',
        function()
            require('telescope.builtin').grep_string()
        end,
        desc = 'Grep current word',
    },
    {
        '<leader>f:',
        function()
            require('telescope.builtin').commands()
        end,
        desc = 'Commands',
    },
    {
        '<leader>fk',
        function()
            require('telescope.builtin').keymaps()
        end,
        desc = 'Keymaps',
    },
    {
        '<leader>fh',
        function()
            require('telescope.builtin').help_tags()
        end,
        desc = 'Help',
    },
    {
        '<leader>fd',
        function()
            require('telescope.builtin').diagnostics()
        end,
        desc = 'Diagnostics',
    },
    {
        '<leader>fn',
        function()
            require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })
        end,
        desc = 'Nvim config',
    },
}

return M
