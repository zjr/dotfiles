return {
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    -- branch = "develop", -- if you want develop branch
    -- keep in mind, it might break everything
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    ---@type gopher.Config
    opts = {},
  },
  {
    "fang2hou/go-impl.nvim",
    ft = "go",
    dependencies = {
      "folke/snacks.nvim",
    },
    opts = {},
    keys = {
      {
        "<leader>ci",
        function()
          require("go-impl").open()
        end,
        mode = { "n" },
        desc = "Go Impl",
      },
    },
  },
}
