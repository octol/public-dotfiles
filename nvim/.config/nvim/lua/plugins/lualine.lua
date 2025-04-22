return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    dependencies = { 'lewis6991/gitsigns.nvim' },

    config = function()
        local function diff_source()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
                return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed
                }
            end
        end

        require('lualine').setup {
            sections = {
                lualine_b = {{'diff', source = diff_source}, 'diagnostics'},
                lualine_c = {{'filename', path = 1}},
            },
            inactive_sections = {
                lualine_c = {{'filename', path = 1}},
            },
            extensions = {'nvim-tree', 'trouble'},
            options = {
                section_separators = '',
                component_separators = '',
            },
        }
    end,
}
