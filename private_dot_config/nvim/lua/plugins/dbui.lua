return {
  {
    "kristijanhusak/vim-dadbod-ui",
    keys = {
      { "<leader>D", "<cmd>DBUIToggle<CR>", desc = "Toggle DBUI" },
      { "<leader><D-s>", "<Plug>(DBUI_ExecuteQuery)<CR>", desc = "DBUI Execute Query", ft = "sql" },
      { "<localleader>e", "<Plug>(DBUI_ExecuteQuery)<CR>", desc = "DBUI Execute Query", ft = "sql" },
    },
    init = function()
      local tmp_path = vim.fn.stdpath("data")
      local cwd_path = vim.fn.getcwd(0)

      vim.g.db_ui_save_location = cwd_path .. "/dadbod_ui"
      vim.g.db_ui_tmp_query_location = tmp_path .. "/dadbod_ui/tmp"

      vim.g.db_ui_auto_execute_table_helpers = 1

      vim.g.db_ui_use_nerd_fonts = true
      vim.g.db_ui_use_nvim_notify = true
      vim.g.db_ui_show_database_icon = true

      -- NOTE: The default behavior of auto-execution of queries on save is disabled
      -- this is useful when you have a big query that you don't want to run every time
      -- you save the file running those queries can crash neovim to run use the
      -- default keymap: <leader>S
      vim.g.db_ui_execute_on_save = false
    end,
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    init = function()
      vim.g.vim_dadbod_completion_lowercase_keywords = 1
    end,
  },
}
