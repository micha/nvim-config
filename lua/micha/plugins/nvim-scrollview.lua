return {
  "dstein64/nvim-scrollview",
  config = function()
    require("scrollview").setup({
      winblend_gui = 50,
      hide_on_cursor_intersect = true,
      excluded_filetypes = { "NvimTree" },
      signs_show_in_folds = true,
      diagnostics_hint_symbol = "󰠠",
      diagnostics_info_symbol = "",
      diagnostics_warn_symbol = "",
      diagnostics_error_symbol = "",
    })
  end,
}
