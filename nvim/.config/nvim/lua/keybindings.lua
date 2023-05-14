-----------------------------------------------------------------------------
-- Macros and keybindings
-----------------------------------------------------------------------------

-- Inserts date
--vim.keymap.set("i", "<F5>",
--    "<C-R>=strftime('\\%a, \\%d \\%b \\%Y \\%H:\\%M:\\%S \\%z')<CR>",
--    { noremap = true, silent = true }
--)

-- --------------------------------------------------------------------------
-- Code navigation
-- --------------------------------------------------------------------------

local keymap_opts = { noremap = true }
--vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, keymap_opts)
vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
--vim.keymap.set("n", "gD", vim.lsp.buf.implementation, keymap_opts)
vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, keymap_opts)
--vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition, keymap_opts)
--vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opts)
--vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, keymap_opts)
--vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, keymap_opts)
--vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)


----nnoremap <silent> gR     <cmd>lua vim.lsp.buf.rename()<CR>
--nnoremap <silent> <leader>rn     <cmd>lua vim.lsp.buf.rename()<CR>
vim.keymap.set("n", "gR", vim.lsp.buf.rename, keymap_opts)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, keymap_opts)

--nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
--nnoremap <silent> gA    <cmd>lua vim.lsp.buf.range_code_action()<CR>
vim.keymap.set("n", "ga", vim.lsp.buf.code_action, keymap_opts)
vim.keymap.set("n", "gA", vim.lsp.buf.range_code_action, keymap_opts)

-----------------------------------------------------------------------------
-- Telescope
-----------------------------------------------------------------------------

--nnoremap <silent> <c-]> <cmd>Telescope lsp_definitions<cr>
--nnoremap <silent> gD <cmd>Telescope lsp_implementations<cr>
--nnoremap <silent> 1gD <cmd>Telescope lsp_type_definitions<cr>
--nnoremap <silent> gr <cmd>Telescope lsp_references<cr>
--nnoremap <silent> g0 <cmd> Telescope lsp_document_symbols<cr>
----nnoremap <silent> gW <cmd>Telescope lsp_workspace_symbols<cr>
--nnoremap <silent> gW <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
--nnoremap <silent> gd <cmd>Telescope lsp_definitions<cr>

--vim.keymap.set("n", "<c-]>", vim.lsp.buf.range_code_action, keymap_opts)
--vim.keymap.set("n", "gD", vim.lsp.buf.range_code_action, keymap_opts)
--vim.keymap.set("n", "1gD", vim.lsp.buf.range_code_action, keymap_opts)
--vim.keymap.set("n", "gr", vim.lsp.buf.range_code_action, keymap_opts)
--vim.keymap.set("n", "g0", vim.lsp.buf.range_code_action, keymap_opts)
--vim.keymap.set("n", "gW", vim.lsp.buf.range_code_action, keymap_opts)
--vim.keymap.set("n", "gW", vim.lsp.buf.range_code_action, keymap_opts)
--vim.keymap.set("n", "gd", vim.lsp.buf.range_code_action, keymap_opts)

----nnoremap <silent> ga <cmd>Telescope lsp_code_actions<cr>
----nnoremap <silent> gA <cmd>Telescope lsp_range_code_actions<cr>
