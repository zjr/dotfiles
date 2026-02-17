return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- So-called 'failed' fixes don't update the buffer despite
      -- fixing several things that _didn't_ fail, which is very annoying.
      --
      -- Ergo exclude errors that can't be fixed
      opts.formatters.sqlfluff.args = { "fix", "-e", "LT05,RF04,AM04", "-" }
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        sqlfluff = {
          args = {
            "lint",
            "--format=json",
            "-",
          },
          parser = function(output, _)
            local per_filepath = {}
            if #output > 0 then
              local status, decoded = pcall(vim.json.decode, output)
              if not status then
                per_filepath = {
                  {
                    filepath = "stdin",
                    violations = {
                      {
                        source = "sqlfluff",
                        line_no = 1,
                        line_pos = 1,
                        code = "jsonparsingerror",
                        description = output,
                      },
                    },
                  },
                }
              else
                per_filepath = decoded
              end
            end
            local diagnostics = {}
            for _, i_filepath in ipairs(per_filepath) do
              for _, violation in ipairs(i_filepath.violations) do
                local severity = vim.diagnostic.severity.WARN
                if violation.code == "PRS" then
                  severity = vim.diagnostic.severity.ERROR
                end
                table.insert(diagnostics, {
                  source = "sqlfluff",
                  lnum = (violation.line_no or violation.start_line_no) - 1,
                  col = (violation.line_pos or violation.start_line_pos) - 1,
                  end_lnum = violation.end_line_no and (violation.end_line_no - 1) or nil,
                  end_col = violation.end_line_pos and (violation.end_line_pos - 1) or nil,
                  severity = severity,
                  message = violation.description,
                  code = violation.code,
                  user_data = { lsp = { code = violation.code } },
                })
              end
            end
            return diagnostics
          end,
        },
      },
    },
  },
}
