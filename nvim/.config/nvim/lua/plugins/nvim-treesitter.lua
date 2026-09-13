return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    -- The main branch does not support lazy-loading
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "lua",
        "rust",
        "toml",
        "python",
        "markdown",
        "markdown_inline",
        "vim",
        "json",
        "yaml",
      })

      -- The main branch no longer manages highlighting; Neovim does. Start it
      -- for any filetype we happen to have a parser for.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(ev) pcall(vim.treesitter.start, ev.buf) end,
      })
    end,
  },
}
