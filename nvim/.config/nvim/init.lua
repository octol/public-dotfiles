--vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set the leader for use on layouts where the default backslash is
-- inconvenient
vim.g.mapleader = ","

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

-----------------------------------------------------------------------------
-- Core options, keymaps, and settings, etc
-----------------------------------------------------------------------------

require("config.options")
require("config.keymaps")
require("config.autocmds")

-----------------------------------------------------------------------------
-- Setup lazy.nvim
-----------------------------------------------------------------------------

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "dracula" } }, -- colorscheme that will be used when installing plugins
  checker = { enabled = false }, -- automatically check for plugin updates
})

-- Theme
vim.cmd.colorscheme("dracula")
