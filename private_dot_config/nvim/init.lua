-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- tell dap to look for launch.json files
require("dap.ext.vscode").load_launchjs(vim.fn.getcwd() .. "/.vscode/launch.json", {})
