return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters.sqlfluff.args = { "fix", "--exclude-rules=LT05", "-" }
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = { linters = { sqlfluff = { args = { "lint", "--format=json" } } } },
  },
}
