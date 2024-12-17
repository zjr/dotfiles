return {
  {
    "zk-org/zk-nvim",
    lazy = false,
    config = function()
      require("zk").setup({
        picker = "fzf_lua",
      })
    end,
    keys = {
      { "<leader>z", desc = "notes" },
      -- Change to the notebook directory
      { "<leader>zc", "<Cmd>ZkCd<CR>", desc = "cd to notebook" },
      -- Create a new note after asking for its title
      { "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", desc = "new note" },
      -- Open notes
      { "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", desc = "open note" },
      -- Open notes associated with the selected tags
      { "<leader>zt", "<Cmd>ZkTags<CR>", desc = "open with selected tags" },
      -- Search for the notes matching a given query
      {
        "<leader>zf",
        "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
        desc = "search for notes",
      },
      -- Search for the notes matching the current visual selection
      { "<leader>zf", mode = { "v" }, ":'<,'>ZkMatch<CR>", desc = "search for notes with selection" },
    },
    lsp = {
      -- `config` is passed to `vim.lsp.start_client(config)`
      config = {
        cmd = { "zk", "lsp" },
        name = "zk",
        -- on_attach = ...
        -- etc, see `:h vim.lsp.start_client()`
      },
      -- automatically attach buffers in a zk notebook that match the given filetypes
      auto_attach = {
        enabled = true,
        filetypes = { "markdown" },
      },
    },
  },
}
