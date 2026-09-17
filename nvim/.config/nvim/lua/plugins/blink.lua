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
        preset = "super-tab",
        ["<C-y>"] = { "select_and_accept", "fallback" },
      },
      cmdline = {
        keymap = {
          -- Share buffer completion navigation, including Up/Down.
          preset = "inherit",
          -- Also let Tab open completion when the menu is hidden.
          ["<Tab>"] = { "select_and_accept", "show_and_insert_or_accept_single", "fallback" },
        },
        completion = {
          menu = { auto_show = false },
          ghost_text = { enabled = false },
        },
      },
      snippets = { preset = "luasnip" },
      -- sources.default is already { "lsp", "path", "snippets", "buffer" };
    },
  },
}
