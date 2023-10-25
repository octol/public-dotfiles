-----------------------------------------------------------------------------
-- Global editing settings
-----------------------------------------------------------------------------

-- Set the leader for use on layouts where the default backslash is
-- inconvenient
vim.g.mapleader = ','

vim.opt.shell = '/bin/bash'     -- To avoid slowdowns on fish shell
vim.opt.clipboard='unnamed'     -- use X11 clipboard always
vim.opt.linebreak = true
vim.opt.scrolloff = 2
vim.opt.smartcase = true
vim.opt.ignorecase = true
--vim.opt.autochdir = true
vim.opt.breakindent = true      -- indent wrapped lines to preserve indendation
vim.opt.linebreak = true        -- soft-wrap only at certain characters
--vim.opt.nojoinspaces = true     -- don't do double spaces after '.'

-----------------------------------------------------------------------------
-- Tabs
--  When using soft tabs (spaces) then we should set expandtab, shiftwidth,
--  softtabstop. Tabstop should be kept at 8.
--  When using hard tabs (^T) then we set tabstop and shiftwidth
-----------------------------------------------------------------------------

vim.opt.expandtab = true      -- use spaces, not tabs
vim.opt.shiftwidth = 4        -- indents of 4, e.g. < commands use this
vim.opt.softtabstop = 4
vim.opt.shiftround = true     -- round indent to nearest shiftwidth multiple

-----------------------------------------------------------------------------
-- Operational settings
-----------------------------------------------------------------------------

-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force user to select one from the menu
vim.o.completeopt = "menuone,noinsert,noselect"

-- Avoid showing extra messages when using completion
vim.opt.shortmess = vim.opt.shortmess + "c"

-- Set updatetime for CursorHold
-- 3000ms of no cursor movement to trigger CursorHold
vim.opt.updatetime = 3000

-- Jump to last position when opening a file
-- TODO: translate from vimscript
--au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

-- Show diagnostic popup on cursor hold
local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
    group = diag_float_grp,
})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd.colorscheme("dracula")

local _border = "single"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = _border
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = _border
  }
)

vim.diagnostic.config{
  float={border=_border}
}
