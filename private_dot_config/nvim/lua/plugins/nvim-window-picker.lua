return {
  "s1n7ax/nvim-window-picker",
  lazy = true,
  name = "window-picker",
  version = "2.*",
  config = function()
    require("window-picker").setup({
      hint = "floating-big-letter",
    })
  end,
}
