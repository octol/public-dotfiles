-- return {
--   "github/copilot.vim",
--   config = function()
--     -- copilot has tab clash
--     vim.g.copilot_no_tab_map = true
--
--     vim.g.copilot_filetypes = {
--       ["*"] = false,
--       ["javascript"] = true,
--       ["typescript"] = true,
--       ["lua"] = true,
--       ["rust"] = true,
--       ["c"] = true,
--       ["c++"] = true,
--       ["go"] = true,
--       ["python"] = true,
--       ["proto"] = true,
--       ["toml"] = true,
--     }
--
--     vim.keymap.set("i", "<leader>j", 'copilot#Accept("\\<CR>")', { silent = true, expr = true, replace_keycodes = false })
--   end,
-- }

return {
  "zbirenbaum/copilot.lua",
  dependencies = {
    "copilotlsp-nvim/copilot-lsp",
  },
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    -- Since system node may be outdated, try to find a node v22+ installation
    -- via nvm. Users can also set COPILOT_NODE_COMMAND to override this.
    local function node_version(node) return vim.fn.systemlist({ node, "-v" })[1] or "" end

    local function parse_node_version(version)
      local major, minor, patch = version:match("^v(%d+)%.(%d+)%.(%d+)")
      if not major then return nil end
      return { major = tonumber(major), minor = tonumber(minor), patch = tonumber(patch) }
    end

    local function version_gte(lhs, rhs)
      if lhs.major ~= rhs.major then return lhs.major > rhs.major end
      if lhs.minor ~= rhs.minor then return lhs.minor > rhs.minor end
      return lhs.patch >= rhs.patch
    end

    local min_node_version = { major = 22, minor = 13, patch = 0 }

    local function node_version_ok(node)
      local parsed = parse_node_version(node_version(node))
      return parsed and version_gte(parsed, min_node_version)
    end

    local function find_node22()
      if vim.fn.executable("node") == 1 and node_version_ok("node") then return "node" end

      local nvm_dir = vim.env.NVM_DIR or (vim.fn.expand("$HOME") .. "/.nvm")
      local candidates = vim.fn.globpath(nvm_dir .. "/versions/node", "v22*/bin/node", false, true)
      local best, best_version

      for _, candidate in ipairs(candidates) do
        if node_version_ok(candidate) then
          local parsed = parse_node_version(node_version(candidate))
          if parsed and (not best_version or version_gte(parsed, best_version)) then
            best = candidate
            best_version = parsed
          end
        end
      end

      return best
    end

    local copilot_node = vim.env.COPILOT_NODE_COMMAND or find_node22()

    -- Command to show which node copilot is using
    vim.api.nvim_create_user_command("CopilotNode", function()
      local node = copilot_node or "not found"
      local node_path = "n/a"
      if copilot_node then
        node_path = vim.fn.exepath(copilot_node)
        if node_path == "" then node_path = copilot_node end
      end
      local version = copilot_node and node_version(copilot_node) or "n/a"
      vim.notify(string.format("Copilot node: %s (%s) path=%s", node, version, node_path))
    end, {})

    require("copilot").setup({
      suggestion = {
        auto_trigger = true,
      },
      filetypes = {
        rust = true,
        lua = true,
        python = true,
        javascript = true,
        typescript = true,
        toml = function() return vim.fn.expand("%:t") == "Cargo.toml" end,
        ["*"] = false,
      },
      copilot_node_command = copilot_node,
    })
  end,
}
