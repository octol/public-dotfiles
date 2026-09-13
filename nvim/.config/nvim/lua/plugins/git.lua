return {
  "lewis6991/gitsigns.nvim",
  opts = {
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local function map(mode, l, r, desc, opts)
        opts = opts or {}
        opts.buffer = bufnr
        opts.desc = desc
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      --
      -- codediff renders with extmarks rather than Vim's diff mode, so
      -- 'wo.diff' is false in its panes, and it opens the modified side as a
      -- real file buffer -- which gitsigns attaches to, overwriting codediff's
      -- own ]c/[c. gitsigns only knows about uncommitted changes, so in a view
      -- of committed diffs it would report "No hunks".
      --
      -- Try codediff first: its navigation returns false when the current
      -- tabpage has no codediff session, so this is a no-op elsewhere. Read
      -- package.loaded instead of require() so ]c never forces codediff to
      -- load in an ordinary buffer.
      local function nav_hunk(direction)
        return function()
          local codediff = package.loaded["codediff"]
          if codediff and codediff[direction .. "_hunk"]() then return end
          if vim.wo.diff then
            vim.cmd.normal({ direction == "next" and "]c" or "[c", bang = true })
          else
            gs.nav_hunk(direction)
          end
        end
      end

      map("n", "]c", nav_hunk("next"), "Next Hunk")
      map("n", "[c", nav_hunk("prev"), "Prev Hunk")

      -- Actions
      map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
      map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")
      map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage Hunk (visual)")
      map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset Hunk (visual)")

      map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
      map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")
      map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
      map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame Line")
      map("n", "<leader>hB", gs.blame, "Blame")
      map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle Blame")
      -- map("n", "<leader>hd", gs.diffthis, "Diff This")
      map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff This ~")
      map("n", "<leader>td", gs.toggle_deleted, "Toggle Deleted")

      -- Convenience toggle to easily close the diff afterwards.
      -- This toggles gitsigns diffthis without killing explorer.
      vim.keymap.set("n", "<leader>hd", function()
        local api = vim.api
        local wins = api.nvim_list_wins()
        local cur = api.nvim_get_current_win()

        -- Collect all windows that have diff enabled
        local diff_wins = {}
        for _, win in ipairs(wins) do
          local ok, isdiff = pcall(api.nvim_get_option_value, "diff", { win = win })
          if ok and isdiff then table.insert(diff_wins, win) end
        end

        if #diff_wins == 0 then
          -- No diff windows -> start gitsigns diffthis
          require("gitsigns").diffthis()
          return
        end

        -- There *are* diff windows -> close/tidy them up
        -- Keep the currently focused window if it's a diff window; otherwise keep the first diff window
        local keep_win = cur
        local is_cur_diff = false
        for _, win in ipairs(diff_wins) do
          if win == cur then
            is_cur_diff = true
            break
          end
        end
        if not is_cur_diff then keep_win = diff_wins[1] end

        for _, win in ipairs(diff_wins) do
          if api.nvim_win_is_valid(win) then
            -- turn off diff in this window
            pcall(api.nvim_set_option_value, "diff", false, { win = win })

            -- close all diff windows except the one we want to keep
            if win ~= keep_win then pcall(api.nvim_win_close, win, true) end
          end
        end

        -- ensure we're focused on the kept window
        if api.nvim_win_is_valid(keep_win) then api.nvim_set_current_win(keep_win) end
      end, { desc = "Toggle gitsigns diffthis" })
    end,
  },
}
