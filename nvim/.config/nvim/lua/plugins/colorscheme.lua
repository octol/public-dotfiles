-- Dracula ships DiffAdd as dark text on its full-saturation green (#50fa7b),
-- which measures 1.29 contrast against Normal's foreground -- unreadable for
-- anything but a bare line marker, and it forces a foreground so syntax
-- highlighting is lost. DiffDelete is asymmetric: red foreground, no
-- background at all.
--
-- Replace both with the accent blended ~18% into Normal's background, and set 
-- only the background so syntax colours show through. codediff derives its own
-- line and character highlights from these, and re-derives on ColorScheme, so
-- fixing them here fixes codediff, :diffthis and vimdiff alike.
local function fix_dracula_diff_hl()
  if vim.g.colors_name ~= "dracula" then return end
  vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#2f4f42" }) -- contrast 8.45
  vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#4f323c" }) -- contrast 10.67
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = fix_dracula_diff_hl,
  desc = "Make dracula's diff backgrounds readable",
})

return {
  { 
    "Mofiqul/dracula.nvim", 
    lazy = false, 
    priority = 1000 ,
    config = function()
      -- The ColorSchene autocmd above does not fire of the colorscheme that
      -- is already active when this file loads, so apply it once directly.
      fix_dracula_diff_hl()
  },
  { "catppuccin/nvim" },
  { "folke/tokyonight.nvim" },
}
