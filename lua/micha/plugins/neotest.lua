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
      "<leader>tc",
      function()
        require("neotest").output_panel.clear()
      end,
      desc = "Clear output panel",
    },
    {
      "<leader>tO",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Toggle output panel",
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open({ enter = true, auto_close = true, last_run = true })
      end,
      desc = "Toggle output",
    },
    {
      "<leader>tss",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle",
    },
    {
      "<leader>tsm",
      function()
        require("neotest").summary.run_marked()
      end,
      desc = "Run marked",
    },
    {
      "<leader>tjn",
      function()
        require("neotest").jump.next()
      end,
      desc = "Next",
    },
    {
      "<leader>tjp",
      function()
        require("neotest").jump.prev()
      end,
      desc = "Prev",
    },
    {
      "<leader>tjN",
      function()
        require("neotest").jump.next({ status = "failed" })
      end,
      desc = "Next (failed)",
    },
    {
      "<leader>tjP",
      function()
        require("neotest").jump.prev({ status = "failed" })
      end,
      desc = "Prev (failed)",
    },
    {
      "<leader>tra",
      function()
        require("neotest").run.run({ suite = true, strategy = "dap" })
      end,
      desc = "All",
    },
    {
      "<leader>trf",
      function()
        require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
      end,
      desc = "File",
    },
    {
      "<leader>trl",
      function()
        require("neotest").run.run_last({ strategy = "dap" })
      end,
      desc = "Last",
    },
    {
      "<leader>trr",
      function()
        require("neotest").run.run({ strategy = "dap" })
      end,
      desc = "Nearest",
    },
    {
      "<leader>trs",
      function()
        require("neotest").run.stop({ interactive = true })
      end,
      desc = "Stop",
    },
    {
      "<leader>tww",
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
      desc = "Toggle",
    },
    {
      "<leader>tws",
      function()
        require("neotest").watch.stop()
      end,
      desc = "Stop",
    },
  },
}
