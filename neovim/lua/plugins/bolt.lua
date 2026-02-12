local key_prefix = '<leader>s'
local function createKeyMap(keybind, command, description, opts)
    return {
        key_prefix .. keybind,
        function()
            require('bolt-server')[command](opts)
        end,
        desc = description,
    }
end

return {
    -- 'git@github.com:bolteu/bolt-server.nvim',
    dir = '~/repos/bolt.nvim',
    dependencies = {
        'folke/snacks.nvim',
    },
    cond = function()
        local dir = vim.fn.getcwd()
        while true do
            local path = dir .. '/package.json'
            if vim.fn.filereadable(path) == 1 then
                local content = vim.fn.readfile(path, '', 5)
                for _, line in ipairs(content) do
                    if line:find('"name": "taxify-server"', 1, true) then return true end
                end
            end
            if dir == vim.env.HOME then break end
            local parent = vim.fn.fnamemodify(dir, ':h')
            if parent == dir then break end
            dir = parent
        end
        return false
    end,
    config = function()
        local terminal = require('bolt-server.terminal')
        require('bolt-server').setup({
            term_configs = {
                test = terminal.configs.bottom_split,
                compile = terminal.configs.bottom_split,
                genapi = terminal.configs.bottom_split,
            },
        })
    end,
    keys = {
        createKeyMap('b', 'find_service', 'service [b]ootstrap'),
        createKeyMap('f', 'find_service_files', 'service [f]iles'),
        {
            key_prefix .. 'F',
            function()
                Snacks.picker.files({
                    cwd = require('bolt-server').find_parent_subdir('test'),
                })
            end,
            desc = 'service tests',
        },
        createKeyMap('d', 'find_service_db_schema', 'service [d]atabase'),
        createKeyMap('/', 'grep_service_files', 'live /grep service'),
        createKeyMap('s', 'compile_service', 'compile [s]ervice', { watch = true }),
        createKeyMap('S', 'compile_service', 'compile [S]ervice (force)', { watch = true, force = true }),
        createKeyMap('<c-s>', 'compile_service', 'compile [^s]ervice with tests', { with_tests = true, watch = true }),
        createKeyMap('g', 'api_gen_service', '[g]enerate api'),

        createKeyMap('<c-x>', 'select_test_to_run', 'select test to run'),
        createKeyMap('x', 'run_test_under_cursor', 'e[x]ecute test under cursor'),
        createKeyMap('X', 'run_test_under_cursor', 'e[X]ecute & watch test under cursor', { watch = true }),

        createKeyMap('T', 'run_buffer_tests', 'run all [t]ests in buffer'),

        createKeyMap('ts', 'run_service_spec_tests', 'run server [s]pec tests'),
        createKeyMap('tc', 'run_service_comp_tests', 'run server [c]omp tests'),

        createKeyMap('v', 'goto_api_definition', 'goto api definition'),
        createKeyMap('V', 'goto_api_endpoint', 'goto api endpoint'),

        createKeyMap('q', 'toggle_terminal', 'toggle terminal'),
        createKeyMap('Q', 'close_terminal', 'close terminal'),
    },
}
