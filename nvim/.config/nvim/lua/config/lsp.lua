----------------------------------------------------------------------------
-- Language servers
--
-- Server configs live in after/lsp/<name>.lua and merge on top of the
-- definitions nvim-lspconfig ships in lsp/<name>.lua. See :help lsp-config.
--
-- Rust is handled separatey by rustaceanvim.
----------------------------------------------------------------------------

vim.lsp.enable("basedpyright")

----------------------------------------------------------------------------
-- Buffer-local LSP keymaps
--
-- Neovim maps grn/gra/grr/gri/grt/grx/gO globally, and K/<C-]>/gq on attach
-- (:help lsp-defaults). We keep those key names and swap only the UI, using
-- the snacks pickers for fuzzy filtering and a live preview.
--
-- These are deliberately buffer-local: gd is the builtin local-declaration
-- motion and gO is the help-buffer table of contents, so binding them
-- globally would break both outside LSP buffers.
----------------------------------------------------------------------------

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Point the default LSP keymaps at the snacks pickers",
  callback = function(ev)
    local function map(lhs, fn, desc) vim.keymap.set("n", lhs, fn, { buffer = ev.buf, desc = desc }) end

    map("gd", function() Snacks.picker.lsp_definitions() end, "Goto Definition")
    map("gD", function() Snacks.picker.lsp_declarations() end, "Goto Declaration")
    map("grr", function() Snacks.picker.lsp_references() end, "References")
    map("gri", function() Snacks.picker.lsp_implementations() end, "Goto Implementation")
    map("grt", function() Snacks.picker.lsp_type_definitions() end, "Goto Type Definition")
    map("gO", function() Snacks.picker.lsp_symbols() end, "LSP Symbols")
    map("<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, "LSP Workspace Symbols")
  end,
})
