return {
  "rcarriga/nvim-notify",
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("notify").setup({
      render = "compact",
      top_down = false,
    })
  end,
}
