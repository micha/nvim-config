return {
  "numToStr/FTerm.nvim",
  keys = {
    {
      "<leader>tt",
      function()
        require("FTerm").toggle()
      end,
      desc = "Toggle terminal",
    },
    {
      "<leader>ts",
      function()
        require("FTerm").scratch({ cmd = "bash" })
      end,
      desc = "Toggle scratch",
    },
    {
      "<C-t>",
      '"xy<CR><CMD>lua require("FTerm").open()<CR><CMD>lua vim.fn.chansend(require("FTerm").get_job_id(), string.gsub(vim.fn.getreg("x"), "%s*$", "").."\\n")<CR>',
      -- function()
      --   local ft = require("FTerm")
      --   local cmd = table.concat(vim.fn.getregion(vim.fn.getpos("'<"), vim.fn.getpos("'>")), "\n")
      --   vim.fn.chansend(ft.get_job_id(), cmd.."\n")
      --   ft.open()
      -- end,
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
