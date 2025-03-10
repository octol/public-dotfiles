return {
    'nvim-tree/nvim-tree.lua',
    requires = {
        'nvim-tree/nvim-web-devicons', -- optional
    },
    config = function()
        -- Consider moving this to the very beginning of init.lua
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- optionally enable 24-bit colour
        vim.opt.termguicolors = true

        require('nvim-tree').setup {
            sort_by = "case_sensitive",
            view = {
                width = 40,
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = false,
            },
            git = {
                enable = false,
            },
        }

        vim.keymap.set('n', '<F2>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>tt', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>tf', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })
    end,
}
