----------------------------------------------------------------------------
-- Language servers
--
-- Rust is handled separatey by rustaceanvim.
----------------------------------------------------------------------------

vim.lsp.enable("basedpyright")


----------------------------------------------------------------------------
-- Buffer-local LSP keymaps
----------------------------------------------------------------------------

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Point the default LSP keymaps at the snacks pickers",
  callback = function(ev)
    local function map(lhs, fn, desc)
      vim.keymap.set("n", lhs, fn, { buffer = ev.buf, desc = desc })
    end

    map("gd", function() Snacks.pickers.lsp_definitions() end, "Goto Definition")
    map("gD", function() Snacks.pickers.lsp_declarations() end, "Goto Declaration")
    map("grr", function() Snacks.pickers.lsp_references() end, "References")
    map("gri", function() Snacks.pickers.lsp_implementations() end, "Goto Implementation")
    map("grt", function() Snacks.pickers.lsp_type_definitions() end, "Goto Type Definition")
    map("gO", function() Snacks.pickers.lsp_symbols() end, "LSP Symbols")
    map("<leader>sS", function() Snacks.pickers.lsp_workspace_symbols() end, "LSP Workspace Symbols")
  end,
})
