-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Repeat movement with ; and ,
local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Floating terminal
map("n", "<c-\\>", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
map("t", "<C-\\>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- Save with cmd+s
map("n", "<D-s>", "<cmd>w<cr>", { desc = "Save buffer with cmd+s" })
