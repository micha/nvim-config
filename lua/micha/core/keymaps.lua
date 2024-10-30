vim.keymap.set("n", "ZZ", "<CMD>qa<CR>", { desc = "Quit neovim", remap = false })
vim.keymap.set("n", "Q", "<CMD>bd<CR>", { desc = "Close and delete buffer", remap = false })
vim.keymap.set("n", "aj", "i<CR><ESC>", { desc = "Break line at cursor", remap = false })
-- vim.keymap.set("n", "<CR>", "<CMD>nohlsearch<CR>", { desc = "Toggle search highlight", remap = false })
