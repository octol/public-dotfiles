return {
    'github/copilot.vim',
    config = function()
        -- copilot has tab clash
        vim.g.copilot_no_tab_map = true
        -- vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

        vim.g.copilot_filetypes = {
            ["*"] = false,
            ["javascript"] = true,
            ["typescript"] = true,
            ["lua"] = false,
            ["rust"] = true,
            ["c"] = true,
            ["c++"] = true,
            ["go"] = true,
            ["python"] = true,
            ["proto"] = true,
        }

        -- vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
        vim.api.nvim_set_keymap('i', '<leader>j', 'copilot#Accept("<CR>")', { silent = true, expr = true })
        vim.api.nvim_set_keymap('i', '<C-B>', 'copilot#Accept("<CR>")', { silent = true, expr = true })

    end,
}
