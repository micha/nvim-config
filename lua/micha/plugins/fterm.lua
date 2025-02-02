return {
  "numToStr/FTerm.nvim",
  keys = {
    {
      "<A-i>",
      '<CMD>lua require("FTerm").toggle()<CR>',
      mode = { "n" },
      desc = "Toggle floating terminal",
    },
    {
      "<A-i>",
      '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>',
      mode = { "t" },
      desc = "Toggle floating terminal",
    },
    {
      "<C-t>",
      '"xy<CR><CMD>lua require("FTerm").open()<CR><CMD>lua vim.fn.chansend(require("FTerm").get_job_id(), string.gsub(vim.fn.getreg("x"), "%s*$", "").."\\n")<CR>',
      mode = { "v" },
      desc = "Send selection",
    },
  },
}
