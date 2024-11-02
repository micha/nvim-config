return {
  "folke/which-key.nvim",
  event = "VimEnter",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 50
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    icons = {
      mappings = false,
      keys = {},
    },

    -- Key chains
    spec = {
      { "<leader>d", group = "Debugger" },
      { "<leader>e", group = "Explorer" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Hunk" },
      { "<leader>l", group = "LSP" },
      { "<leader>n", group = "Neorg/Noice" },
      { "<leader>t", group = "Terminal" },
      { "<leader>x", group = "Trouble" },
    },
  },
}
