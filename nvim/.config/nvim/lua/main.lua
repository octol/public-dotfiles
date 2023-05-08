-----------------------------------------------------------------------------
-- System default settings
--  These are lifted from debian defaults (debian.vim). Set these explicitly
--  in case we are on a different platform.
-----------------------------------------------------------------------------

vim.g.nocompatible = true     -- use Vim defaults instead of 100% vi compatibility
vim.opt.backspace = 'indent,eol,start'  -- more powerful backspacing
vim.opt.history = 50          -- keep 50 lines of command line history
vim.opt.ruler = true          -- show the cursor position all the time

-- Set the leader for use on layouts where the default backslash is
-- inconvenient
vim.g.mapleader = ','

-- To avoid slowdowns on fish shell
vim.opt.shell = '/bin/bash'

-----------------------------------------------------------------------------
-- Global editing settings
-----------------------------------------------------------------------------

vim.opt.clipboard='unnamed'       -- use X11 clipboard always
--vim.opt.textwidth = 0            " 0 is the defaults, 72 linux kern, 79 python
vim.opt.showcmd = true                 -- display incomplete commands

vim.opt.incsearch = true               -- do incremental searching
--vim.opt.hlsearch = true
vim.opt.linebreak = true
vim.opt.scrolloff = 2
vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.hidden = true                 -- background buffers can be unsaved
--vim.opt.novisualbell = true
vim.opt.laststatus = 2
vim.opt.wildmode = 'longest,list,full'
vim.opt.wildmenu = true
vim.opt.wildignore = '*.o,*~,*.pyc,*.pyo,*.so'
--vim.opt.autochdir = true
vim.opt.breakindent = true             -- indent wrapped lines to preserve indendation
vim.opt.linebreak = true               -- soft-wrap only at certain characters
--vim.opt.nojoinspaces = true            -- don't do double spaces after '.'

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
