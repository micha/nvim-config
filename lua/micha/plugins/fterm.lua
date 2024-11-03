return {
  "numToStr/FTerm.nvim",
  keys = {
    {
      "<leader>Tt",
      function()
        require("FTerm").toggle()
      end,
      desc = "Toggle terminal",
    },
    {
      "<leader>Ts",
      function()
        ---@diagnostic disable-next-line: missing-fields
        require("FTerm").scratch({ cmd = "bash" })
      end,
      desc = "Toggle scratch",
    },
    {
      "<C-t>",
      '"xy<CR><CMD>lua require("FTerm").open()<CR><CMD>lua vim.fn.chansend(require("FTerm").get_job_id(), string.gsub(vim.fn.getreg("x"), "%s*$", "").."\\n")<CR>',
      mode = { "v" },
      desc = "Send selection",
    },
    {
      "<C-\\><C-c>",
      function()
        require("FTerm").close()
      end,
      desc = "Close terminal",
      mode = { "n", "t" },
    },
  },
}
