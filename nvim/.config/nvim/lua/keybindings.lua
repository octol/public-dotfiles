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

vim.keymap.set("n", "gR", vim.lsp.buf.rename, keymap_opts)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, keymap_opts)

vim.keymap.set("n", "ga", vim.lsp.buf.code_action, keymap_opts)
--vim.keymap.set("n", "gA", vim.lsp.buf.range_code_action, keymap_opts)


-- Goto previous/next diagnostic warning/error
vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, keymap_opts)
vim.keymap.set("n", "g]", vim.diagnostic.goto_next, keymap_opts)

-- Format
vim.keymap.set("n", "<leader>bf", function() vim.lsp.buf.format { async = true } end, keymap_opts)

-----------------------------------------------------------------------------
-- Telescope
-----------------------------------------------------------------------------

local builtin = require('telescope.builtin')

vim.keymap.set("n", "<c-]>", builtin.lsp_definitions, keymap_opts)
vim.keymap.set("n", "gD", builtin.lsp_implementations, keymap_opts)
vim.keymap.set("n", "1gD", builtin.lsp_type_definitions, keymap_opts)
vim.keymap.set("n", "gr", builtin.lsp_references, keymap_opts)
vim.keymap.set("n", "g0", builtin.lsp_document_symbols, keymap_opts)
--vim.keymap.set("n", "gW", builtin.lsp_workspace_symbols, keymap_opts)
vim.keymap.set("n", "gW", builtin.lsp_dynamic_workspace_symbols, keymap_opts)
vim.keymap.set("n", "gd", builtin.lsp_definitions, keymap_opts)

----nnoremap <silent> ga <cmd>Telescope lsp_code_actions<cr>
----nnoremap <silent> gA <cmd>Telescope lsp_range_code_actions<cr>

vim.keymap.set('n', '<c-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-----------------------------------------------------------------------------
-- Trouble
-----------------------------------------------------------------------------

local trouble_opts = { silent = true, noremap = true }
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", trouble_opts)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", trouble_opts)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", trouble_opts)
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", trouble_opts)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", trouble_opts)
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", trouble_opts)

-----------------------------------------------------------------------------
-- Crates
-----------------------------------------------------------------------------

local crates = require('crates')
local opts = { silent = true }

vim.keymap.set('n', '<leader>ct', crates.toggle, opts)
vim.keymap.set('n', '<leader>cr', crates.reload, opts)

vim.keymap.set('n', '<leader>cv', crates.show_versions_popup, opts)
vim.keymap.set('n', '<leader>cf', crates.show_features_popup, opts)
vim.keymap.set('n', '<leader>cd', crates.show_dependencies_popup, opts)

vim.keymap.set('n', '<leader>cu', crates.update_crate, opts)
vim.keymap.set('v', '<leader>cu', crates.update_crates, opts)
vim.keymap.set('n', '<leader>ca', crates.update_all_crates, opts)
vim.keymap.set('n', '<leader>cU', crates.upgrade_crate, opts)
vim.keymap.set('v', '<leader>cU', crates.upgrade_crates, opts)
vim.keymap.set('n', '<leader>cA', crates.upgrade_all_crates, opts)

vim.keymap.set('n', '<leader>cH', crates.open_homepage, opts)
vim.keymap.set('n', '<leader>cR', crates.open_repository, opts)
vim.keymap.set('n', '<leader>cD', crates.open_documentation, opts)
vim.keymap.set('n', '<leader>cC', crates.open_crates_io, opts)

-----------------------------------------------------------------------------
-- nvim-tree
-----------------------------------------------------------------------------

vim.keymap.set('n', '<F2>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tt', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tf', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })

-----------------------------------------------------------------------------
-- Comment.nvim
-----------------------------------------------------------------------------

vim.api.nvim_set_keymap("n", "<C-_>", "<Cmd>lua require('Comment.api').toggle.linewise.current()<CR>", {})
vim.api.nvim_set_keymap("v", "<C-_>", "gc", {})
vim.api.nvim_set_keymap("n", "<C-/>", "<Cmd>lua require('Comment.api').toggle.linewise.current()<CR>", {})
vim.api.nvim_set_keymap("v", "<C-/>", "gc", {})

-----------------------------------------------------------------------------
-- copilot
-----------------------------------------------------------------------------

-- vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<leader>j', 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<C-B>', 'copilot#Accept("<CR>")', { silent = true, expr = true })

-----------------------------------------------------------------------------
-- vim-floatterm
-----------------------------------------------------------------------------

-- vim.keymap.set('n', "<leader>ft", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 fish <CR> ")
-- vim.keymap.set('n', "t", ":FloatermToggle myfloat<CR>")
-- vim.keymap.set('t', "<Esc>", "<C-\\><C-n>:q<CR>")
