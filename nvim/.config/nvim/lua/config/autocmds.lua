-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Briefly highlight yanked text",
  callback = function() vim.hl.on_yank({ timeout = 200 }) end,
})
