return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        -- rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run the first available formatter
        javascript = { "prettierd", "prettier", stop_after_first = true },
        json = { "jq" },
      },
    },
    keys = {
      {
        "<leader>bf",
        function() require("conform").format({ async = true, lsp_fallback = true }) end,
        desc = "Format buffer or range",
        mode = { "n", "v" },
      },
    },
  },
}
