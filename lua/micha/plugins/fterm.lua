return {
  "numToStr/FTerm.nvim",
  keys = {
    { "<A-i>", '<CMD>lua require("FTerm").toggle()<CR>', mode = { "n" } },
    { "<A-i>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', mode = { "t" } },
    {
      "<C-t>",
      '"xy<CR><CMD>lua require("FTerm").open()<CR><CMD>lua vim.fn.chansend(require("FTerm").get_job_id(), string.gsub(vim.fn.getreg("x"), "%s*$", "").."\\n")<CR>',
      mode = { "v" },
      desc = "Send selection",
    },
  },
}
