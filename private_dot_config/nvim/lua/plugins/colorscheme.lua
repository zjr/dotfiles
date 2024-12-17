return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "storm",
      -- transparent = true,
      styles = {
        -- sidebars = "transparent",
        -- floats = "transparent",
      },
    },
  },
  {
    "catppuccin",
    opts = {
      flavour = "frappe", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "frappe",
      },
      transparent_background = false,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
