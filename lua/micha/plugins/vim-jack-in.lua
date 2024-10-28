return {
  "clojure-vim/vim-jack-in",
  dependencies = {
    "tpope/vim-dispatch",
    "radenling/vim-dispatch-neovim",
  },
  keys = {
    { "<leader>tc", "<CMD>Clj<CR>", desc = "Start clojure REPL server" },
  },
}
