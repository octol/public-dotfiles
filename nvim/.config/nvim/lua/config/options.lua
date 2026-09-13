local opt = vim.opt

-----------------------------------------------------------------------------
-- Global editing settings
-----------------------------------------------------------------------------

opt.clipboard = "unnamedplus"
opt.scrolloff = 2
opt.sidescrolloff = 4
opt.splitright = true
opt.splitbelow = true
opt.smartcase = true
opt.ignorecase = true
opt.breakindent = true -- indent wrapped lines to preserve indendation
opt.linebreak = true -- soft-wrap only at certain characters

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
