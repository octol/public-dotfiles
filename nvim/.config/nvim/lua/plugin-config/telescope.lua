require("telescope").setup {
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
                -- even more opts
            }
        }
    },
    pickers = {
        -- ignore_current_buffer = true,
        -- sort_lastused = true,
        -- sorting_strategy = "ascending",
        buffers = {
            sort_mru = true,
            mappings = {
                i = {
                    ["<C-d>"] = "delete_buffer",
                },
            },
        },
    }
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")
