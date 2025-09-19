local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<leader>a", function() vim.cmd.RustLsp("codeAction") end, { silend = true, buffer = bufnr, desc = "Code action" })

vim.keymap.set("n", "K", function() vim.cmd.RustLsp({ "hover", "actions" }) end, { silend = true, buffer = bufnr, desc = "Hover actions" })

vim.keymap.set("n", "<leader>rc", function() vim.cmd.RustLsp("openCargo") end, { silend = true, buffer = bufnr, desc = "Open Cargo.toml" })

vim.keymap.set("n", "<leader>rd", function() vim.cmd.RustLsp("renderDiagnostic") end, { silend = true, buffer = bufnr, desc = "Render diagnostic" })

vim.keymap.set("n", "<leader>re", function() vim.cmd.RustLsp("explainDiagnostic") end, { silend = true, buffer = bufnr, desc = "Explain diagnostic" })

vim.keymap.set("n", "<leader>rm", function() vim.cmd.RustLsp("expandMacro") end, { silend = true, buffer = bufnr, desc = "Expand macro" })

vim.keymap.set("n", "<leader>rh", function() vim.cmd.RustLsp({ "hover", "range" }) end, { silend = true, buffer = bufnr, desc = "Hover range" })

vim.keymap.set("n", "<leader>rp", function() vim.cmd.RustLsp("parentModule") end, { silend = true, buffer = bufnr, desc = "Go to parent module" })
