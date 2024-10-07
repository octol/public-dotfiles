-----------------------------------------------------------------------------
-- Bootstrap lazy.nvim
-----------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
--vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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

-----------------------------------------------------------------------------
-- Macros and keybindings
-----------------------------------------------------------------------------

-- Insert date
function insert_command_output(command)
    local output = vim.fn.system(command)
    -- Remove the trailing newline character from the output
    output = output:gsub("\n$", "")
    vim.api.nvim_put({output}, "c", true, true)
end

vim.keymap.set(
    'n',
    '<leader>dt',
    [[<cmd>lua insert_command_output("date --rfc-email")<CR>]],
    { noremap = true, silent = true }
)

-----------------------------------------------------------------------------
-- Code navigation
-----------------------------------------------------------------------------

local keymap_opts = { noremap = true }
--vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, keymap_opts)
--vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
--vim.keymap.set("n", "gD", vim.lsp.buf.implementation, keymap_opts)
vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, keymap_opts)
--vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition, keymap_opts)
--vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opts)
--vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, keymap_opts)
--vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, keymap_opts)
--vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)

--vim.keymap.set("n", "gR", vim.lsp.buf.rename, keymap_opts)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, keymap_opts)

vim.keymap.set("n", "ga", vim.lsp.buf.code_action, keymap_opts)
--vim.keymap.set("n", "gA", vim.lsp.buf.range_code_action, keymap_opts)


-- Goto previous/next diagnostic warning/error
vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, keymap_opts)
vim.keymap.set("n", "g]", vim.diagnostic.goto_next, keymap_opts)

-- Format
vim.keymap.set("n", "<leader>bf", function() vim.lsp.buf.format { async = true } end, keymap_opts)

-- Inlay hints
vim.lsp.inlay_hint.enable(true)
local function toggle_inlay_hints()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(nil))
end
vim.keymap.set("n", "<leader>h", toggle_inlay_hints, keymap_opts)

-- Rustaceanvim
vim.g.rustaceanvim = {
  server = {
    default_settings = {
      ['rust-analyzer'] = {
          diagnostics = {
              disabled = { "inactive-code" },
          },
      },
    },
  },
}

-----------------------------------------------------------------------------
-- Setup lazy.nvim
-----------------------------------------------------------------------------

require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },

    -- Themes
    { 'Mofiqul/dracula.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme dracula]])
        end,
    },
    { "catppuccin/nvim", as = "catppuccin" },
    { "folke/tokyonight.nvim" },

    { 'nvim-tree/nvim-web-devicons', lazy = true },

    -- General
    { 'vimoutliner/vimoutliner' },
    { 'jamessan/vim-gnupg' },
    { 'ntpeters/vim-better-whitespace' },
    { 'editorconfig/editorconfig-vim' },

    -- LSP diagnostics highlight groups for color schemes that don't yet
    -- support the Neovim 0.5 builtin lsp client.
    --{ 'folke/lsp-colors.nvim' },

    -- { 'mtdl9/vim-log-highlighting' },
    -- { 'andreshazard/vim-logreview' },
    { 'christoomey/vim-tmux-navigator' },

    { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },

    { 'tpope/vim-fugitive' },
    { 'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    },

    { "j-hui/fidget.nvim", opts = {} },
    { 'stevearc/dressing.nvim', opts = {} },

    { "chrisgrieser/nvim-lsp-endhints", event = "LspAttach", opts = {} },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "dracula" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})
