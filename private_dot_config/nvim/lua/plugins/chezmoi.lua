local pick_chezmoi = function()
  if LazyVim.pick.picker.name == "telescope" then
    require("telescope").extensions.chezmoi.find_files()
  elseif LazyVim.pick.picker.name == "fzf" then
    local fzf_lua = require("fzf-lua")
    local actions = {
      ["enter"] = function(selected)
        fzf_lua.actions.vimcmd_entry("ChezmoiEdit", selected, { cwd = os.getenv("HOME") })
      end,
    }
    fzf_lua.files({
      cmd = "chezmoi managed --include=files,symlinks",
      actions = actions,
      hidden = false,
      cwd = os.getenv("HOME"),
    })
  elseif LazyVim.pick.picker.name == "snacks" then
    local results = require("chezmoi.commands").list({
      args = {
        "--path-style",
        "absolute",
        "--include",
        "files",
        "--exclude",
        "externals",
      },
    })
    local items = {}
    for _, czFile in ipairs(results) do
      table.insert(items, {
        text = czFile,
        file = czFile,
      })
    end
    ---@type snacks.picker.Config
    local opts = {
      items = items,
      confirm = function(picker, item)
        picker:close()
        require("chezmoi.commands").edit({
          targets = { item.text },
          args = { "--watch" },
        })
      end,
    }
    Snacks.picker.pick(opts)
  end
end

return {
  {
    "xvzc/chezmoi.nvim",
    keys = {
      {
        "<leader>sz",
        pick_chezmoi,
        desc = "Chezmoi",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        disable = function()
          -- check if 'filetype' option includes 'chezmoitmpl'
          if string.find(vim.bo.filetype, "chezmoitmpl") then
            return true
          end
        end,
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      local chezmoi_entry = {
        icon = " ",
        key = "c",
        desc = "Config",
        action = pick_chezmoi,
      }
      local config_index
      for i = #opts.dashboard.preset.keys, 1, -1 do
        if opts.dashboard.preset.keys[i].key == "c" then
          table.remove(opts.dashboard.preset.keys, i)
          config_index = i
          break
        end
      end
      table.insert(opts.dashboard.preset.keys, config_index, chezmoi_entry)
    end,
  },
}
