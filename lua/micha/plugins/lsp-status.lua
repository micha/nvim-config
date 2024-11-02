return {
  "nvim-lua/lsp-status.nvim",
  config = function()
    local lsp_status = require("lsp-status")
    lsp_status.register_progress()
    lsp_status.config({
      indicator_separator = "",
      status_symbol = "",
      indicator_errors = "E",
      indicator_warnings = "W",
      indicator_info = "i",
      indicator_hint = "?",
      -- indicator_ok = "Ok",
    })
  end,
}
