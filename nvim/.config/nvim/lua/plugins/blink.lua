return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    -- Deliberately not lazy-loaded; blink installs its own InsertEnter and
    -- CmdlineEnter triggers, and its plugin/ file registers LSP capabilities
    -- via vim.lsp.config('*').
    dependencies = {
      { "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "default",
        ["<C-y>"] = { "select_and_accept", "fallback" },
      },
      snippets = { preset = "luasnip" },
      -- sources.default is already { "lsp", "path", "snippets", "buffer" };
    },
  },
}
