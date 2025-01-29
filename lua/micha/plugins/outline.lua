return {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  keys = { -- Example mapping to toggle outline
    { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
  },
  opts = {
    -- Your setup opts here
    outline_window = {
      position = "left",
      width = 25,
      relative_width = false,
    },

    symbol_folding = {
      autofold_depth = 2,
    },

    symbols = {
      filter = {
        default = { "Function", "Class" },
      },
    },
  },
}
