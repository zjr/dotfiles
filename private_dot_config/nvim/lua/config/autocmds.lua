-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Removes & add padding when entering & exiting NVim, respectively.
-- See: https://github.com/wez/wezterm/issues/5561
-- See RE LazyVimAutocmds: https://github.com/LazyVim/LazyVim/issues/2592
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimAutocmds",
  callback = function()
    --NVIM_ENTER=1
    vim.cmd([[call chansend(v:stderr, "\033]1337;SetUserVar=NVIM_ENTER=MQ==\007")]])
  end,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    --NVIM_ENTER=0
    vim.cmd([[call chansend(v:stderr, "\033]1337;SetUserVar=NVIM_ENTER=MA==\007")]])
  end,
})
