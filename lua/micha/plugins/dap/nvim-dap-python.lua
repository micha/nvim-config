return {
  "mfussenegger/nvim-dap-python",
  ft = "python",
  dependencies = {
    "mfussenegger/nvim-dap",
    config = function(_, opts)
      local path = "python"
      require("dap-python").setup(path)
    end,
  },
}

