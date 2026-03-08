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
      "<leader>md",
      function() require("harpoon"):list():remove() end,
      desc = "Harpoon Remove File",
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
    {
      "<leader>5",
      function() require("harpoon"):list():select(5) end,
      desc = "Harpoon File 5",
    },
    {
      "<leader>6",
      function() require("harpoon"):list():select(6) end,
      desc = "Harpoon File 6",
    },
    {
      "<leader>7",
      function() require("harpoon"):list():select(7) end,
      desc = "Harpoon File 7",
    },
    {
      "<leader>8",
      function() require("harpoon"):list():select(8) end,
      desc = "Harpoon File 8",
    },
    {
      "<leader>9",
      function() require("harpoon"):list():select(9) end,
      desc = "Harpoon File 9",
    },
  },
  config = function(_, opts)
    local harpoon = require("harpoon")
    local extensions = require("harpoon.extensions")

    harpoon:setup(opts)
    harpoon:extend(extensions.builtins.highlight_current_file())
    harpoon:extend(extensions.builtins.navigate_with_number())
  end,
}
