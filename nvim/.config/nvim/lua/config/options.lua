local opt = vim.opt

-----------------------------------------------------------------------------
-- Global editing settings
-----------------------------------------------------------------------------

opt.shell = "/bin/bash" -- To avoid slowdowns on fish shell
opt.clipboard = "unnamedplus"
opt.linebreak = true
opt.scrolloff = 2
opt.sidescrolloff = 4
opt.splitright = true
opt.splitbelow = true
opt.smartcase = true
opt.ignorecase = true
--opt.autochdir = true
opt.breakindent = true -- indent wrapped lines to preserve indendation
opt.linebreak = true -- soft-wrap only at certain characters
--opt.nojoinspaces = true     -- don't do double spaces after '.'

-----------------------------------------------------------------------------
-- Tabs
--  When using soft tabs (spaces) then we should set expandtab, shiftwidth,
--  softtabstop. Tabstop should be kept at 8.
--  When using hard tabs (^T) then we set tabstop and shiftwidth
-----------------------------------------------------------------------------

opt.expandtab = true -- use spaces, not tabs
opt.shiftwidth = 4 -- indents of 4, e.g. < commands use this
opt.softtabstop = 4
opt.shiftround = true -- round indent to nearest shiftwidth multiple

-----------------------------------------------------------------------------
-- Operational settings
-----------------------------------------------------------------------------

-- Set updatetime for CursorHold
-- 3000ms of no cursor movement to trigger CursorHold
opt.updatetime = 3000

-----------------------------------------------------------------------------
-- Folding
-----------------------------------------------------------------------------

opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 1
opt.foldnestmax = 4
opt.foldenable = false

-----------------------------------------------------------------------------
-- Diagnostics
-----------------------------------------------------------------------------

local signs = {
  Error = "",
  Warn = "",
  Hint = "",
  Info = "",
}

local signConf = {
  text = {},
  texthl = {},
  numhl = {},
}

for type, icon in pairs(signs) do
  local severityName = string.upper(type)
  local severity = vim.diagnostic.severity[severityName]
  local hl = "DiagnosticSign" .. type
  signConf.text[severity] = icon
  signConf.texthl[severity] = hl
  signConf.numhl[severity] = hl
end

vim.diagnostic.config({
  underline = true,
  virtual_text = true,
  -- virtual_lines = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
  signs = signConf,
})

vim.o.winborder = "rounded"

-- Toggle between virtual_text and virtual_lines
vim.keymap.set("n", "gK", function()
  local config = vim.diagnostic.config()
  if config.virtual_text and not config.virtual_lines then
    vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
    print("Diagnostics: virtual_lines")
  elseif config.virtual_lines and not config.virtual_text then
    vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
    print("Diagnostics: virtual_text")
  else
    vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
    print("Diagnostics: virtual_lines")
  end
end, { silent = true, desc = "Toggle diagnostic display" })

-----------------------------------------------------------------------------
-- LSP
-----------------------------------------------------------------------------

vim.lsp.enable("basedpyright")
