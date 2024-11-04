return {
  "folke/which-key.nvim",
  event = "VimEnter",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 100
  end,
  opts = {
    icons = {
      mappings = false,
      keys = {},
    },
    spec = {
      { "<leader>d", group = "Debugger" },
      { "<leader>e", group = "Explorer" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Hunk" },
      { "<leader>l", group = "LSP" },
      { "<leader>n", group = "Noice" },
      { "<leader>t", group = "Test"},
      { "<leader>T", group = "Terminal" },
      { "<leader>x", group = "Trouble" },
    },
  },
}
