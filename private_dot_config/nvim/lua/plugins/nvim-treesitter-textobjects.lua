return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  opts = {
    textobjects = {
      swap = {
        enable = true,
        swap_next = {
          ["<C-.>"] = "@parameter.inner",
        },
        swap_previous = {
          ["<C-,>"] = "@parameter.inner",
        },
      },
    },
  },
}
