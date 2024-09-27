return {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
    -- opts = function(_, opts)
    --   opts.server = opts.server or {}
    --   opts.server.settings = opts.server.settings or {}
    --   opts.server.settings["rust-analyzer"] = opts.server.settings["rust-analyzer"] or {}
    --   opts.server.settings["rust-analyzer"].procMacro = { enable = true }
    --   -- opts.server.settings["rust-analyzer"].diagnostics = {
    --   --   enable = true,
    --   --   disabled = { "inactive-code" },
    --   --   enableExperimental = true,
    --   -- }
    -- end,
}
