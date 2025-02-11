return {
    'git@github.com:bolteu/bolt.nvim',
    dependencies = {
        'nvim-telescope/telescope-file-browser.nvim',
    },
    opts = {
        bootstrap = '<leader>sb',
        comp = '<leader>sC',
        db = '<leader>sd',
        find_files_service = '<leader>sf',
        grep_service = '<leader>s/',
        service_ctests = '<leader>sX',
        run_all_ctests = '<leader>sxa',
        select_ctest_to_run = '<leader>sxs',
        run_ctest_under_cursor = '<leader>sxx',
        compile_service = '<leader>scs',
        compile_service_force = '<leader>scS',
        compile_service_with_tests = '<leader>sct',
        api_gen_service = '<leader>sg',
    },
}
