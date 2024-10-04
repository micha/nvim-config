vim.keymap.set("n", "ZZ", "<CMD>qa!<CR>", { desc = "Quit neovim without saving", remap = false })
vim.keymap.set("n", "Q", "<CMD>bd<CR>", { desc = "Close and delete buffer", remap = false })
vim.keymap.set("n", "aj", "i<CR><ESC>", { desc = "Break line at cursor", remap = false })

-- toggle search highlighting
vim.cmd("let hlstate=0")
vim.keymap.set(
  "n",
  "<CR><CR>",
  "<CMD>if (hlstate == 0) | nohlsearch | else | set hlsearch | endif | let hlstate=1-hlstate<CR>",
  { desc = "Toggle search highlight", remap = false }
)
