return {
  { "iamcco/markdown-preview.nvim", enabled = false },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },

    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      code = {
        width = "full",
        right_pad = 1,
        border = "thin",
        language_border = " ",
        language_left = "",
        language_right = "",
      },
      heading = {
        sign = true,
        position = "inline",
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
    },
  },
  {
    "tadmccorkle/markdown.nvim",
    ft = "markdown",
    keys = {
      { "<localleader>e", "<Plug>(markdown_toggle_emphasis)", desc = "Toggle Emphasis", ft = "markdown" },
      {
        "<localleader>e",
        "<Plug>(markdown_toggle_emphasis_visual)",
        desc = "Toggle Emphasis",
        ft = "markdown",
        mode = "v",
      },
      { "<localleader>ee", "<Plug>(markdown_toggle_emphasis_line)", desc = "Toggle Emphasis Line", ft = "markdown" },
      { "<localleader>ce", "<Plug>(markdown_change_emphasis)", desc = "Change Emphasis", ft = "markdown" },
      { "<localleader>de", "<Plug>(markdown_delete_emphasis)", desc = "Delete Emphasis", ft = "markdown" },
      { "<localleader>l", "<Plug>(markdown_add_link)", desc = "Add Link", ft = "markdown" },
      { "<localleader>l", "<Plug>(markdown_add_link_visual)", desc = "Add Link", ft = "markdown", mode = "v" },
      { "<localleader>gx", "<Plug>(markdown_follow_link)", desc = "Follow Link", ft = "markdown" },
      { "<localleader>gh", "<Plug>(markdown_go_current_heading)", desc = "Go to Heading", ft = "markdown" },
      { "<localleader>gp", "<Plug>(markdown_go_parent_heading)", desc = "Go to Parent", ft = "markdown" },
      { "<localleader>g;", "<Plug>(markdown_go_next_heading)", desc = "Go to Next Heading", ft = "markdown" },
      { "<localleader>d,", "<Plug>(markdown_go_prev_heading)", desc = "Go to Prev Heading", ft = "markdown" },
      { "<localleader>o", "<cmd>MDListItemBelow<cr>", desc = "Inert List Item Below", ft = "markdown" },
      { "<localleader>O", "<cmd>MDListItemAbove<cr>", desc = "Inert List Item Above", ft = "markdown" },
    },
    opts = {
      mappings = false,
      on_attach = function(bufnr)
        local map = vim.keymap.set
        local opts = { buffer = bufnr }

        map({ "n", "i" }, "<M-cr>", "<Cmd>MDListItemBelow<CR>", opts)
        map({ "n", "i" }, "<M-o>", "<Cmd>MDListItemBelow<CR>", opts)
        map({ "n", "i" }, "<M-O>", "<Cmd>MDListItemAbove<CR>", opts)

        map("n", "<M-c>", "<Cmd>MDTaskToggle<CR>", opts)
        map("x", "<M-c>", ":MDTaskToggle<CR>", opts)

        local function toggle(key, x)
          return (x and "<Esc>gv" or "")
            .. "<Cmd>lua require'markdown.inline'"
            .. ".toggle_emphasis_visual'"
            .. key
            .. "'<CR>"
        end

        vim.keymap.set("v", "<C-b>", toggle("b"), opts)
        vim.keymap.set("v", "<C-i>", toggle("i"), opts)
        vim.keymap.set("v", "<C-x>", toggle("x"), opts)
        vim.keymap.set("v", "<C-c>", toggle("c"), opts)

        vim.keymap.set("x", "<C-b>", toggle("b", true), opts)
        vim.keymap.set("x", "<C-i>", toggle("i", true), opts)
        vim.keymap.set("x", "<C-x>", toggle("x", true), opts)
        vim.keymap.set("x", "<C-c>", toggle("c", true), opts)
      end,
      inline_surround = {
        strong = {
          key = "b",
          txt = "**",
        },
        emphasis = {
          key = "i",
          txt = "_",
        },
        strikethrough = {
          key = "x",
          txt = "~~",
        },
        code = {
          key = "c",
          txt = "`",
        },
      },
      link = {
        paste = {
          enable = true, -- whether to convert URLs to links on paste
        },
      },
      toc = {
        -- Comment text to flag headings/sections for omission in table of contents.
        omit_heading = "toc omit heading",
        omit_section = "toc omit section",
        -- Cycling list markers to use in table of contents.
        -- Use '.' and ')' for ordered lists.
        markers = { "-" },
      },
      -- Hook functions allow for overriding or extending default behavior.
      -- Called with a table of options and a fallback function with default behavior.
      -- Signature: fun(opts: table, fallback: fun())
      hooks = {
        -- Called when following links. Provided the following options:
        -- * 'dest' (string): the link destination
        -- * 'use_default_app' (boolean|nil): whether to open the destination with default application
        --   (refer to documentation on <Plug> mappings for explanation of when this option is used)
        follow_link = nil,
      },
    },
  },
  {
    "wallpants/github-preview.nvim",
    cmd = { "GithubPreviewToggle" },
    keys = {
      { mode = "n", "<leader>cp", "<cmd>GithubPreviewToggle<cr>", desc = "Preview Markdown Toggle" },
    },
    opts = {
      details_tags_open = true,
    },
    config = function(_, opts)
      local gpreview = require("github-preview")
      gpreview.setup(opts)

      local fns = gpreview.fns
      vim.keymap.set("n", "<leader>mpt", fns.toggle)
      vim.keymap.set("n", "<leader>mps", fns.single_file_toggle)
      vim.keymap.set("n", "<leader>mpd", fns.details_tags_toggle)
    end,
  },
}
