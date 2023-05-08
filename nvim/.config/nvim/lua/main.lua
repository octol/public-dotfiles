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

-- Jump to last position when opening a file
-- TODO: translate from vimscript
--au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

vim.cmd.colorscheme("dracula")

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

