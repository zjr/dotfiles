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

-- Gitlab-CI YAML LS
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.gitlab-ci*.{yml,yaml}",
  callback = function()
    vim.bo.filetype = "yaml.gitlab"
  end,
})

-- This is slated for v0.13 release (current 12.5)
-- local last ---@type vim.event.cmdatom.data?
--
-- vim.api.nvim_create_autocmd("CmdAtom", {
--   callback = function(ev)
--     -- Skip edits, and the "," mapping itself.
--     local motion = ev.data.moved or ev.match == "motion"
--
--     if motion and not (ev.data.changed or ev.data.lhs == ",") then
--       last = ev.data
--     end
--   end,
-- })
--
-- vim.keymap.set("n", ",", function()
--   -- CmdAtom is deferred; schedule the replay, in case "," follows a motion.
--   vim.schedule(function()
--     if last then
--       vim.api.nvim_feedkeys(last.keys or last.lhs, last.keys and "n" or "m", false)
--     end
--   end)
-- end)
