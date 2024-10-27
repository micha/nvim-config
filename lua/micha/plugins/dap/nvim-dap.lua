return {
  "mfussenegger/nvim-dap",

  keys = {
    { "<leader>db", "<CMD>DapToggleBreakpoint<CR>", desc = "Toggle breakpoint" },
    { "<leader>dc", "<CMD>DapContinue<CR>", desc = "Continue" },
    {
      "<leader>dd",
      function()
        require("dapui").toggle()
      end,
      desc = "Toggle debugger",
    },
  },
}
