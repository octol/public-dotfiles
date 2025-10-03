return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
    { "lewis6991/gitsigns.nvim" },
  },

  opts = {
    sections = {
      lualine_b = { "diagnostics" },
      lualine_c = { { "filename", path = 1 } },
    },
    -- inactive_sections = {
    --   lualine_c = { { "filename", path = 1 } },
    -- },
    extensions = { "nvim-tree", "trouble" },
  },
}
