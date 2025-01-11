return {
  "mfussenegger/nvim-dap",

  -- keys = {
  --   { "<leader>db", "<CMD>DapToggleBreakpoint<CR>", desc = "Toggle breakpoint" },
  --   { "<leader>dc", "<CMD>DapContinue<CR>", desc = "Continue" },
  --   {
  --     "<leader>dd",
  --     function()
  --       require("dapui").toggle()
  --     end,
  --     desc = "Toggle debugger",
  --   },
  -- },

  keys = function(_, keys)
    local dap = require("dap")
    local dapui = require("dapui")
    return {
      { "<leader>dd", dapui.toggle, desc = "Toggle UI" },
      { "<leader>ds", dap.status, desc = "Toggle UI" },
      { "<leader>dbb", dap.toggle_breakpoint, desc = "Toggle" },
      {
        "<leader>dbB",
        function()
          dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Set",
      },
      { "<leader>dbc", dap.clear_breakpoints, desc = "Clear" },
      { "<leader>dbe", dap.set_exception_breakpoints, desc = "Exception" },
      { "<leader>dbl", dap.list_breakpoints, desc = "List (quickfix)" },
      { "<leader>dsi", dap.step_into, desc = "Into" },
      { "<leader>dso", dap.step_over, desc = "Over" },
      { "<leader>dsO", dap.step_out, desc = "Out" },
      { "<leader>dss", dap.continue, desc = "Start/continue" },
      unpack(keys),
    }
  end,
}
