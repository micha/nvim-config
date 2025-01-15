return {
  "mfussenegger/nvim-dap",

  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },

  keys = function(_, keys)
    local dap = require("dap")
    local dapui = require("dapui")

    local input = function(prompt)
      local result = vim.fn.input(prompt)
      if result == "" then
        return nil
      else
        return result
      end
    end

    return {
      { "<leader>dd", dapui.toggle, desc = "Toggle UI" },
      { "<leader>ds", dap.status, desc = "Toggle UI" },
      { "<leader>dbb", dap.toggle_breakpoint, desc = "Toggle" },
      {
        "<leader>dbB",
        function()
          dap.set_breakpoint(input("Condition: "), input("Hit: "), input("Log: "))
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
