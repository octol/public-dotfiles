-- Resolve the remote's default branch from origin/HEAD, so the review mappings
-- work in repos that use master as well as main, and substitute it into `template`.
local function against_base(template)
  return function()
    local res = vim.system({ "git", "symbolic-ref", "--short", "refs/remotes/origin/HEAD" }, { text = true }):wait()
    local base = res.code == 0 and vim.trim(res.stdout or "") or ""
    if base == "" then
      vim.notify("codediff: no origin/HEAD here; run `git remote set-head origin -a`", vim.log.levels.WARN)
      return
    end
    vim.cmd(template:format(base))
  end
end

-- The explorer only has a global `focus_on_select`, so <CR> either always follows
-- the file into the diff or never does. Flip the option around one select to get
-- a second mapping that does follow, leaving <CR> as the stay-in-the-list preview.
local function select_and_focus()
  local explorer = require("codediff.config").options.explorer
  local saved = explorer.focus_on_select
  explorer.focus_on_select = true
  -- The "x" flag runs the explorer's own <CR> mapping now instead of queueing it,
  -- so the option is still true when that handler reads it.
  vim.api.nvim_feedkeys(vim.keycode("<CR>"), "mx", false)
  explorer.focus_on_select = saved
end

return {
  {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
    opts = {
      -- Default is 40, which truncates longer paths in the file list.
      explorer = {
        width = 60,
        view_mode = "tree",
      },
    },
    -- The explorer's mappings are buffer-local and installed by the plugin itself,
    -- so hook its filetype rather than declaring this in `keys`.
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "codediff-explorer",
        callback = function(args) vim.keymap.set("n", "o", select_and_focus, { buffer = args.buf, desc = "Open diff and focus it" }) end,
      })
    end,
    keys = {
      { "<leader>dd", "<cmd>CodeDiff<cr>", desc = "Diff working tree" },
      -- `...` is git merge-base syntax, so these show only what this branch
      -- added, not what landed on the default branch since it was cut.
      -- Careful: codediff reads an omitted right side as the working tree,
      -- where git would default it to HEAD. That is the only difference
      -- between the two mappings below. In the shell, `dr` is
      -- `git diff $(git merge-base HEAD origin/main)`.
      { "<leader>dr", against_base("CodeDiff %s..."), desc = "Review branch (incl. uncommitted)" },
      { "<leader>dR", against_base("CodeDiff %s...HEAD"), desc = "Review branch (committed only)" },
      { "<leader>ds", "<cmd>CodeDiff --staged<cr>", desc = "Diff staged" },
      { "<leader>df", "<cmd>CodeDiff file HEAD<cr>", desc = "Diff this file vs HEAD" },
      { "<leader>dh", "<cmd>CodeDiff history<cr>", desc = "Commit history" },
      -- Two dots here on purpose: `history` wants a commit range, not a diff.
      { "<leader>dH", against_base("CodeDiff history %s..HEAD"), desc = "Branch commits" },
    },
  },
}
