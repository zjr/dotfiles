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
      tailwindcss = {
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                -- strings: ('"`)
                { "\\b\\w*Style\\b\\s*=\\s*[\"'`]([^\"'`]*)[\"'`]" },
                { "\\b\\w*Class\\b\\s*=\\s*[\"'`]([^\"'`]*)[\"'`]" },
                { "\\b\\w*Classes\\b\\s*=\\s*[\"'`]([^\"'`]*)[\"'`]" },
                -- array: []
                {
                  "[sS]tyles?\\s*=\\s*\\[([\\s\\S]+)\\]",
                  "\\s*[\"'`]([^\"'`]*)[\"'`]",
                },
                {
                  "[cC]lasse?s?\\s*=\\s*\\[([\\s\\S]+)\\]",
                  "\\s*[\"'`]([^\"'`]*)[\"'`]",
                },
                -- POJO
                { ":\\s*?[\"'`]([^\"'`]*).*?,?" },
                -- nested object: { classNames: {}}
                {
                  "classNames:\\s*{([\\s\\S]*?)}",
                  "\\s?[\\w].*:\\s*?[\"'`]([^\"'`]*).*?,?\\s?",
                },
              },
            },
          },
        },
      },
    },
  },
}
