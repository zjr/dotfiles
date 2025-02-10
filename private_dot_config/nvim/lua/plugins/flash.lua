return {
  "folke/flash.nvim",
  event = "VeryLazy",
  vscode = false,
  ---@type Flash.Config
  opts = {
    jump = {
      autojump = true,
    },
    modes = {
      char = {
        jump_labels = false,
        enabled = true,
        keys = { "f", "F", "t", "T", ",", ";" },
        char_actions = function(motion)
          return {
            [";"] = "right",
            [","] = "left",
            [motion:lower()] = "right",
            [motion:upper()] = "left",
          }
        end,
        multi_line = true,
        highlight = { backdrop = false },
      },
    },
  },
  -- stylua: ignore
  keys = {
    "f", "F", "t", "T", ";", ",",
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
