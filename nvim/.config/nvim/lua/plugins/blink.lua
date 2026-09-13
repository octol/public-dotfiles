return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      { "L3MON4D3/LuaSnip", version = "v2.*", build = "make install jsregexp" },
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      keymap = { preset = "default" },
      snippets = { preset = "luasnip" },
    },
  },
}
