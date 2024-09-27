return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup {
            sections = {
                lualine_b = {'diff', 'diagnostics'},
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
