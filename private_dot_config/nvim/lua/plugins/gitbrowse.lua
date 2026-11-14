return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    gitbrowse = {
      url_patterns = {
        ["workshop%.cloud%.gov"] = {
          branch = "/-/tree/{branch}",
          file = "/-/blob/{branch}/{file}#L{line_start}-{line_end}",
          permalink = "/-/blob/{commit}/{file}#L{line_start}-{line_end}",
          commit = "/-/commit/{commit}",
        },
      },
    },
  },
}
