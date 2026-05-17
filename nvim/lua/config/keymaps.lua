-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Terminal open and close with Option - O
map("n", "<A-o>", function()
  Snacks.terminal(nil, { cwd = LazyVim.root(), border = "rounded" })
end, { desc = "Terminal (Root Dir)" })

map("t", "<A-o>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- Live grep to fw
map("n", "<leader>fw", "<cmd>Telescope live_grep<cr>")
