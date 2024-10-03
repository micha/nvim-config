return {
  "folke/which-key.nvim",
  event = "VimEnter",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 250
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
      { "<leader>e", group = "Explorer" },
      { "<leader>f", group = "Find" },
      { "<leader>l", group = "LSP" },
      { "<leader>t", group = "Toggle" },
      { "<leader>x", group = "Trouble" },
    },
  },
}
