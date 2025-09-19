return {
  { "neovim/nvim-lspconfig" },
  { "chrisgrieser/nvim-lsp-endhints", event = "LspAttach", opts = {} },
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
    init = function()
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              diagnostics = {
                disabled = { "inactive-code" },
              },
              cargo = { allFeatures = true },
              procMacro = { enable = true },
            },
          },
        },
      }
    end,
  },
}
