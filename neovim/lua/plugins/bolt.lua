local key_prefix = '<leader>s'
local function createKeyMap(keybind, command, description)
    return {
        key_prefix .. keybind,
        function()
            require('bolt-server')[command]()
        end,
        desc = description,
    }
end

return {
    'git@github.com:bolteu/bolt-server.nvim',
    dependencies = {
        'nvim-telescope/telescope-file-browser.nvim',
        'nvim-telescope/telescope.nvim',
    },
    cond = function()
        local cwd = vim.fn.getcwd()
        return cwd == vim.fn.expand('~/repos/taxify/server')
    end,
    keys = {
        createKeyMap('b', 'find_service', 'service [b]ootstrap'),
        createKeyMap('C', 'find_service_comp_tests', 'service [c]omp tests'),
        createKeyMap('d', 'find_service_db_schema', 'service [d]atabase'),
        createKeyMap('f', 'find_service_files', 'service [f]iles'),
        createKeyMap('/', 'grep_service_files', 'live /grep service'),
        createKeyMap('s', 'compile_service', 'compile [s]ervice'),
        createKeyMap('S', 'compile_service_force', 'compile [S]ervice (force)'),
        createKeyMap('<c-s>', 'compile_service_with_tests', 'compile [^s]ervice with tests'),
        createKeyMap('g', 'api_gen_service', '[g]enerate api'),
        createKeyMap('<c-x>', 'select_comp_test_to_run', 'select comp test to run'),
        createKeyMap('x', 'run_comp_test_under_cursor', 'run comp test under cursor'),
        createKeyMap('X', 'run_buffer_comp_tests', 'run all comp tests in buffer'),
        createKeyMap('<c-s-x>', 'run_service_comp_tests', 'run all comp tests for service'),
        createKeyMap('v', 'goto_api_definition', 'goto api definition'),
        createKeyMap('V', 'goto_api_endpoint', 'goto api endpoint'),
    },
}
