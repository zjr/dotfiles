return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = true,
      exclude = { "go" }, -- filetypes for which you don't want to enable inlay hints
    },
  },
}
