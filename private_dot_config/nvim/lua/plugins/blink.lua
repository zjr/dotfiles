return {
  "saghen/blink.cmp",
  opts = {
    keymap = { preset = "super-tab" },
    signature = {
      enabled = true,
      window = { show_documentation = true },
    },
    completion = {
      trigger = { show_in_snippet = false },
      list = {
        selection = {
          preselect = function()
            return not require("blink.cmp").snippet_active({ direction = 1 })
          end,
        },
      },
    },
  },
}
