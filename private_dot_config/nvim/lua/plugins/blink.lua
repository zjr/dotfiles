local has_words_before = function()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  if col == 0 then
    return false
  end
  local line = vim.api.nvim_get_current_line()
  return line:sub(col - 1, col):match("^%s+$") == nil
end

return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "none",
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },

      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            -- insert only if manually selected
            return cmp.accept()
          elseif has_words_before() then
            return cmp.insert_next()
          end
        end,
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
      ["<C-n>"] = { "select_next", "fallback_to_mappings" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },

      ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
    },
    -- shows function signatures, e.g. when filling in arguments
    signature = {
      enabled = true,
      window = { show_documentation = true },
    },
    completion = {
      list = {
        selection = {
          -- turns off completion pre-selection when completing parts
          -- of a snippet, e.g. tabbing through function arguments
          preselect = function()
            return not require("blink.cmp").snippet_active({ direction = 1 })
          end,
        },
      },
    },
  },
}
