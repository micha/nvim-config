vim.keymap.set("n", "ZZ", "<CMD>qa!<CR>", { desc = "Quit neovim without saving" })
vim.keymap.set("n", "Q", "<CMD>bd<CR>", { desc = "Close and delete buffer" })
vim.keymap.set("n", "aj", "i<CR><ESC>", { desc = "Break line at cursor" })
vim.keymap.set("n", "<CR>", "<CMD>noh<ESC>", { desc = "Toggle search highlight" })
