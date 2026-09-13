-----------------------------------------------------------------------------
-- Diagnostic signs and display
-----------------------------------------------------------------------------

local signs = {
  Error = "",
  Warn = "",
  Hint = "",
  Info = "",
}

local signConf = { text = {}, texthl = {}, numhl = {} }
for name, icon in pairs(signs) do
  local severity = vim.diagnostic.severity[name:upper()]
  local hl = "DiagnosticSign" .. name
  signConf.text[severity] = icon
  signConf.texthl[severity] = hl
  signConf.numhl[severity] = hl
end

vim.diagnostic.config({
  underline = true,
  virtual_text = true,
  update_in_insert = false,
  severity_sort = true,
  signs = signConf,
})

vim.o.winborder = "rounded"

-----------------------------------------------------------------------------
-- Toggle between virtual_text and virtual_lines
-----------------------------------------------------------------------------

vim.keymap.set("n", "gK", function()
  local to_lines = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_text = not to_lines, virtual_lines = to_lines })
  vim.notify("Diagnostics: " .. (to_lines and "virtual_lines" or "virtual_text"))
end, { silent = true, desc = "Toggle diagnostics display" })
