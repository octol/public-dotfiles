-- return {
--   "github/copilot.vim",
--   config = function()
--     -- copilot has tab clash
--     vim.g.copilot_no_tab_map = true
--
--     vim.g.copilot_filetypes = {
--       ["*"] = false,
--       ["javascript"] = true,
--       ["typescript"] = true,
--       ["lua"] = true,
--       ["rust"] = true,
--       ["c"] = true,
--       ["c++"] = true,
--       ["go"] = true,
--       ["python"] = true,
--       ["proto"] = true,
--       ["toml"] = true,
--     }
--
--     vim.keymap.set("i", "<leader>j", 'copilot#Accept("\\<CR>")', { silent = true, expr = true, replace_keycodes = false })
--   end,
-- }

return {
  "zbirenbaum/copilot.lua",
  dependencies = {
    "copilotlsp-nvim/copilot-lsp",
  },
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        auto_trigger = true,
      },
      filetypes = {
        rust = true,
        toml = true,
        lua = true,
        python = true,
        javascript = true,
        typescript = true,
        ["*"] = false,
      },
    })
  end,
}
