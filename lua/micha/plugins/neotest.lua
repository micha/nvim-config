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
          runner = "pytest",
          args = { "-s" },
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
      ---@diagnostic disable-next-line: missing-fields
      output = {
        open_on_run = false,
      },
    })
  end,
  keys = {
    {
      "<leader>to",
      function()
        require("neotest").output.open({ enter = true, auto_close = true, last_run = true })
      end,
      desc = "Toggle output",
    },
    { "<leader>tr", "<CMD>Neotest run<CR>", desc = "Run nearest" },
    { "<leader>tt", "<CMD>Neotest summary<CR>", desc = "Toggle summary panel" },
    {
      "<leader>tw",
      function()
        local path = nil
        if
          pcall(function()
            path = vim.fn.input({
              prompt = "Path to watch",
              completion = "file",
            })
          end)
        then
          if path ~= nil and path ~= "" then
            require("neotest").watch.toggle(path)
          end
        end
      end,
      desc = "Toggle watch",
    },
  },
}
