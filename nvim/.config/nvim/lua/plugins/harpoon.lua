return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {},
  keys = {
    {
      "<leader>a",
      function() require("harpoon"):list():add() end,
      desc = "Harpoon Add File",
    },
    {
      "<C-e>",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Harpoon Menu",
    },
    {
      "<leader>mn",
      function() require("harpoon"):list():next() end,
      desc = "Harpoon Next",
    },
    {
      "<leader>mp",
      function() require("harpoon"):list():prev() end,
      desc = "Harpoon Previous",
    },
    {
      "<leader>1",
      function() require("harpoon"):list():select(1) end,
      desc = "Harpoon File 1",
    },
    {
      "<leader>2",
      function() require("harpoon"):list():select(2) end,
      desc = "Harpoon File 2",
    },
    {
      "<leader>3",
      function() require("harpoon"):list():select(3) end,
      desc = "Harpoon File 3",
    },
    {
      "<leader>4",
      function() require("harpoon"):list():select(4) end,
      desc = "Harpoon File 4",
    },
  },
  config = function(_, opts) require("harpoon"):setup(opts) end,
}
