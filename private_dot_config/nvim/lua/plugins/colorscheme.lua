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
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "auto", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "frappe",
      },
      dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      auto_integrations = true,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        -- component_separators = { left = "", right = "" },
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
