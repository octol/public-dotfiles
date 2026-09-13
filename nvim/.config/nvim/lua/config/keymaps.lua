-----------------------------------------------------------------------------
-- Comments
--
-- Neovim provides gc/gcc natively. These add the two byte sequences that
-- terminals send for Ctrl-/ on top of it. `remap = true` is required, since
-- gc and gcc are themselves mappings
-----------------------------------------------------------------------------

for _, lhs in ipairs({ "<C-_>", "<C-/>" }) do
  vim.keymap.set("n", lhs, "gcc", { remap = true, desc = "Toggle comment" })
  vim.keymap.set("x", lhs, "gc", { remap = true, desc = "Toggle comment" })
end

-----------------------------------------------------------------------------
-- Insert date
-----------------------------------------------------------------------------

function insert_command_output(command)
  local output = vim.fn.system(command)
  vim.api.nvim_put({ output }, "c", true, true)
end

vim.keymap.set("n", "<leader>dt", [[<cmd>lua insert_command_output("date --rfc-email")<CR>]], { noremap = true, silent = true, desc = "Insert date" })

-----------------------------------------------------------------------------
-- Tmux
-----------------------------------------------------------------------------

vim.api.nvim_create_user_command("Tnew", function() os.execute(string.format([[tmux split-window -c "%s"]], vim.fn.getcwd())) end, {})
vim.api.nvim_create_user_command("Tvnew", function() os.execute(string.format([[tmux split-window -h -c "%s"]], vim.fn.getcwd())) end, {})
vim.api.nvim_create_user_command("Tneww", function() os.execute(string.format([[tmux new-window -c "%s"]], vim.fn.getcwd())) end, {})
vim.keymap.set("n", "<leader>ts", "<cmd>Tnew<cr>", { noremap = true, silent = true, desc = "Tmux split (horizontal)" })
vim.keymap.set("n", "<leader>tv", "<cmd>Tvnew<cr>", { noremap = true, silent = true, desc = "Tmux split (vertical)" })
vim.keymap.set("n", "<leader>tw", "<cmd>Tneww<cr>", { noremap = true, silent = true, desc = "Tmux new window" })
