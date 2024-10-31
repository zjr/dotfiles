return {
  {
    "folke/tokyonight.nvim",
    opts = { style = "storm", transparent = true },
  },
  {
    "catppuccin/nvim",
    opts = {
      flavour = "frappe", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "frappe",
      },
      transparent_background = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
