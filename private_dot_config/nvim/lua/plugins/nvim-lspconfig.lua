return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = true,
      exclude = { "go" }, -- filetypes for which you don't want to enable inlay hints
    },
    servers = {
      gopls = {
        settings = {
          gopls = {
            buildFlags = { "-tags=integration" },
          },
        },
      },
      yamlls = {
        settings = {
          yaml = {
            customTags = {
              "!reference sequence", -- necessary for gitlab-ci.yaml files
            },
          },
        },
      },
    },
  },
}
