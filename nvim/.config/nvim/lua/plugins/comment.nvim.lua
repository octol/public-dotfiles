return {
    'numToStr/Comment.nvim',
    opts = {
        -- add any options here
    },
    config = function()
        vim.api.nvim_set_keymap("n", "<C-_>", "<Cmd>lua require('Comment.api').toggle.linewise.current()<CR>", {})
        vim.api.nvim_set_keymap("v", "<C-_>", "gc", {})
        vim.api.nvim_set_keymap("n", "<C-/>", "<Cmd>lua require('Comment.api').toggle.linewise.current()<CR>", {})
        vim.api.nvim_set_keymap("v", "<C-/>", "gc", {})
    end
}
