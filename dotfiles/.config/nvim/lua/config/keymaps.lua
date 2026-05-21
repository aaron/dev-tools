-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>r", ":ReloadChrome<CR>", { desc = "Reload Chrome tab" })

vim.keymap.set("i", "<C-]>", function()
  require("copilot.suggestion").accept_word()
end, { desc = "Copilot Accept Word" })

vim.keymap.set("i", "<C-\\>", function()
  require("copilot.suggestion").accept_line()
end, { desc = "Copilot Accept Line" })

vim.keymap.set("n", "<leader>j", function()
  require("config.ruby_split_join").split_call()
end, { desc = "Split Ruby call" })

vim.keymap.set("n", "<leader>J", function()
  require("config.ruby_split_join").join_call()
end, { desc = "Join Ruby call" })
