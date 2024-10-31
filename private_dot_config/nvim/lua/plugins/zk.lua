return {
  {
    "zk-org/zk-nvim",
    config = function()
      require("zk").setup({
        picker = "telescope",
      })
    end,
    keys = {
      { "<leader>z", desc = "notes" },
      -- Create a new note after asking for its title.
      { "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", desc = "new" },
      -- Open notes.
      { "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", desc = "open" },
      -- Open notes associated with the selected tags.
      { "<leader>zt", "<Cmd>ZkTags<CR>", desc = "open with selected tags" },
      -- Search for the notes matching a given query.
      {
        "<leader>zf",
        "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
        desc = "search for notes",
      },
      -- Search for the notes matching the current visual selection.
      { "<leader>zf", ":'<,'>ZkMatch<CR>", desc = "serch for notes with selection" },
    },
  },
  {
    "zk-org/neo-tree-zk.nvim",
    dependencies = {
      "nvim-neo-tree/neo-tree.nvim",
      "zk-org/zk-nvim",
    },
  },
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   opts = {
  --     sources = {
  --       -- default sources
  --       "filesystem",
  --       "buffers",
  --       "git_status",
  --       -- user sources goes here
  --       "zk",
  --     },
  --     zk = {
  --       follow_current_file = true,
  --       window = {
  --         mappings = {
  --           ["n"] = "change_query",
  --         },
  --       },
  --     },
  --   },
  -- },
}
