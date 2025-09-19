return {
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "rust", "toml", "python", "markdown", "vim", "json", "yaml" },
        highlight = {
          enable = true,
          -- disable = { "c" },

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },

        --context_commentstring = {
        --    enable = true,
        --    enable_autocmd = false,
        --},
      })
    end,
  },
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
}
