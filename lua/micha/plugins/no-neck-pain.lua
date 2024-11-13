return {
  "shortcuts/no-neck-pain.nvim",
  version = "*",
  keys = {
    { "<leader>ww", "<CMD>NoNeckPain<CR>", desc = "Focus" },
    { "<leader>ws", "<CMD>NoNeckPainScratchPad<CR>", desc = "Scratch pad" },
    { "<leader>w=", "<CMD>NoNeckPainWidthUp<CR>", desc = "Focus wider" },
    { "<leader>w-", "<CMD>NoNeckPainWidthDown<CR>", desc = "Focus narrower" },
  },
}
