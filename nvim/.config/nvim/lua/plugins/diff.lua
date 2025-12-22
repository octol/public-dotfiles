return {
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("diffview.actions")

      require("diffview").setup({
        use_icons = true,
        enhanced_diff_hl = true,
        view = {
          merge_tool = {
            layout = "diff4_mixed",
            disable_diagnostics = true,
          },
        },
        keymaps = {
          file_panel = {
            { "n", "q", "<cmd>DiffviewClose<CR>" },
          },
        },
      })
    end,
  },
  {
    "esmuellert/vscode-diff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
  },
}
