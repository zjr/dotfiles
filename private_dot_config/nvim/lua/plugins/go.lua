return {
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    -- branch = "develop", -- if you want develop branch
    -- keep in mind, it might break everything
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "mfussenegger/nvim-dap", -- (optional) only if you use `gopher.dap`
    },
    ---@type gopher.Config
    opts = {},
  },
  {
    "fang2hou/go-impl.nvim",
    ft = "go",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      -- Choose one of the following fuzzy finder
      "folke/snacks.nvim",
      -- "ibhagwan/fzf-lua",
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
