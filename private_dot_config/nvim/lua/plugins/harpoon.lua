local harpoon = require("harpoon")
local fzf_lua = require("fzf-lua")

-- Remap <leader>h to use fzf
return {
  "ThePrimeagen/harpoon",
  keys = {
    {
      "<leader>h",
      function()
        local file_paths = {}
        for _, item in ipairs(harpoon:list().items) do
          table.insert(file_paths, item.value)
        end
        fzf_lua.fzf_exec(file_paths, {
          prompt = "Harpoon >",
          actions = require("fzf-lua").defaults.actions.files,
          previewer = "builtin",
        })
      end,
      desc = "Harpoon Quick Menu",
    },
  },
}
