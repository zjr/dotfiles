return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters.sqlfluff.args = { "format", "-" }
    end,
  },
  {
    "mfussenegger/nvim-lint",
    ---@class lintOpts
    ---@field linters table<string, lint.Linter>
    ---@param opts lintOpts
    opts = function(_, opts)
      opts.linters = opts.linters or {}
      opts.linters.sqlfluff = opts.linters.sqlfluff or require("lint.linters.sqlfluff")

      local parser = opts.linters.sqlfluff.parser
      opts.linters.sqlfluff.parser = function(output, ...)
        local infos = "AM04,RF02"
        local diags = parser(output, ...)

        for _, diag in ipairs(diags) do
          if infos:find(diag.code, 1, true) then
            diag.severity = vim.diagnostic.severity.INFO
          end
        end

        return diags
      end

      vim.diagnostic.config(
        { virtual_text = { severity = { min = vim.diagnostic.severity.WARN } } },
        require("lint").get_namespace("sqlfluff")
      )

      return opts
    end,
  },
}
