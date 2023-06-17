--local nvim_lsp = require('lspconfig')

local opts = {
    --tools = { -- rust-tools options
    --    autoSetHints = true,
    --},

    --runnables = {
    --    use_telescope = true,
    --},

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                check = {
                    command = "clippy",
                },
                cargo = {
                    features = "all",
                },
                procMacro = {
                    enable = true,
                },
                -- diagnostics = {
                --     disabled = { "unresolved-import" },
                -- },
            }
        }
    },
}

require('rust-tools').setup(opts)

