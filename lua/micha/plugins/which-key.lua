return {
  "folke/which-key.nvim",
  event = "VimEnter",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 250
  end,
  opts = {
    icons = {
      mappings = false,
      keys = {},
    },
    spec = {
      { "<leader>d", group = "Debugger" },
      { "<leader>db", group = "Breakpoint" },
      { "<leader>ds", group = "Step" },
      { "<leader>e", group = "Explorer" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Hunk" },
      { "<leader>l", group = "LSP" },
      { "<leader>n", group = "Noice" },
      { "<leader>t", group = "Test"},
      { "<leader>td", group = "Debug"},
      { "<leader>tr", group = "Run"},
      { "<leader>tw", group = "Watch"},
      { "<leader>T", group = "Terminal" },
      { "<leader>w", group = "Focus" },
      { "<leader>x", group = "Trouble" },
      { "[o", group = "Enable" },
      { "]o", group = "Disable" },
    },
  },
}
