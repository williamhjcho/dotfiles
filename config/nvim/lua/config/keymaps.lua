-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
map("n", "<leader>w-", "<c-w>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>w|", "<c-w>v", { desc = "Split Window Right", remap = true })
