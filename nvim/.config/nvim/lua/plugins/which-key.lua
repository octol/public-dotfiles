return {
  "folke/which-key.nvim",
  depends = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    delay = function(ctx) return ctx.plugin and 0 or 1000 end,
  },
}
