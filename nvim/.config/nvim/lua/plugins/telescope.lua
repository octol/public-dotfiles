
return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    requires = {
        { 'nvim-lua/plenary.nvim' },
    },
    config = function()

        vim.keymap.set("n", "<c-]>", "<cmd>Telescope lsp_definitions<cr>", keymap_opts)
        vim.keymap.set("n", "gD", "<cmd>Telescope lsp_implementations<cr>", keymap_opts)
        vim.keymap.set("n", "1gD", "<cmd>Telescope lsp_type_definitions<cr>", keymap_opts)
        vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", keymap_opts)
        vim.keymap.set("n", "g0", "<cmd>Telescope lsp_document_symbols<cr>", keymap_opts)
        vim.keymap.set("n", "gW", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", keymap_opts)
        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", keymap_opts)

        vim.keymap.set('n', '<c-p>', "<cmd>Telescope git_files<cr>", {})
        vim.keymap.set('n', '<leader>ff', "<cmd>Telescope find_files<cr>", {})
        vim.keymap.set('n', '<leader>fg', "<cmd>Telescope live_grep<cr>", {})
        vim.keymap.set('n', '<leader>fb', "<cmd>Telescope buffers<cr>", {})
        vim.keymap.set('n', '<leader>fh', "<cmd>Telescope help_tags<cr>", {})
    end,
}
