return {
  "MeanderingProgrammer/render-markdown.nvim",

  dependencies = { "nvim-treesitter/nvim-treesitter" },

  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    code = {
      width = "full",
      right_pad = 1,
    },
    heading = {
      sign = true,
      position = "inline",
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
    },
  },
}
