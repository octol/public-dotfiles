return {
  "lewis6991/gitsigns.nvim",
  opts = {
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local function map(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc }) end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then return "]c" end
        vim.schedule(function() gs.next_hunk() end)
        return "<Ignore>"
      end, "Next Hunk")

      map("n", "[c", function()
        if vim.wo.diff then return "[c" end
        vim.schedule(function() gs.prev_hunk() end)
        return "<Ignore>"
      end, "Prev Hunk")

      -- Actions
      map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
      map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")
      map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage Hunk (visual)")
      map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage Hunk (visual)")

      map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
      map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")
      map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
      map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame Line")
      map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle Blame")
      map("n", "<leader>hd", gs.diffthis, "Diff This")
      map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff This ~")
      map("n", "<leader>td", gs.toggle_deleted, "Toggle Deleted")
    end,
  },
}
