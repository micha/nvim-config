return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = true },
        }),
        require("neotest-plenary"),
        require("neotest-vim-test")({
          ignore_file_types = { "python", "vim", "lua" },
        }),
      },
      ---@diagnostic disable-next-line: missing-fields
      summary = {
        open = "botright vsplit | vertical resize 35",
      },
    })
  end,
  keys = {
    { "<leader>tr", "<CMD>Neotest run<CR>", desc = "Run nearest" },
    { "<leader>tt", "<CMD>Neotest summary<CR>", desc = "Toggle summary" },
  },
}
