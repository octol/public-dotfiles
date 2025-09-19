-----------------------------------------------------------------------------
-- Goto previous/next diagnostic warning/error
-----------------------------------------------------------------------------

vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, { noremap = true, desc = "Go to previous diagnostic" })
vim.keymap.set("n", "g]", vim.diagnostic.goto_next, { noremap = true, desc = "Go to next diagnostic" })

-----------------------------------------------------------------------------
-- Insert date
-----------------------------------------------------------------------------

function insert_command_output(command)
  local output = vim.fn.system(command)
  -- Remove the trailing newline character from the output
  output = output:gsub("\n$", "")
  vim.api.nvim_put({ output }, "c", true, true)
end

vim.keymap.set("n", "<leader>dt", [[<cmd>lua insert_command_output("date --rfc-email")<CR>]], { noremap = true, silent = true, desc = "Insert date" })

-----------------------------------------------------------------------------
-- LSP keymaps
-----------------------------------------------------------------------------

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, keymap_opts)

-----------------------------------------------------------------------------
-- Tmux
-----------------------------------------------------------------------------

vim.api.nvim_create_user_command("Tnew", function()
  local cwd = vim.fn.getcwd()
  local tmux_cmd = string.format([[tmux split-window -c "%s"]], cwd)
  os.execute(tmux_cmd)
end, {})
vim.api.nvim_create_user_command("Tvnew", function()
  local cwd = vim.fn.getcwd()
  local tmux_cmd = string.format([[tmux split-window -h -c "%s"]], cwd)
  os.execute(tmux_cmd)
end, {})
vim.api.nvim_create_user_command("Tneww", function()
  local cwd = vim.fn.getcwd()
  local tmux_cmd = string.format([[tmux new-window -c "%s"]], cwd)
  os.execute(tmux_cmd)
end, {})
vim.keymap.set("n", "<leader>ts", ":Tnew<CR>", { noremap = true, silent = true, desc = "Tmux split (horizontal)" })
vim.keymap.set("n", "<leader>tv", ":Tvnew<CR>", { noremap = true, silent = true, desc = "Tmux split (vertical)" })
vim.keymap.set("n", "<leader>tw", ":Tneww<CR>", { noremap = true, silent = true, desc = "Tmux new window" })
