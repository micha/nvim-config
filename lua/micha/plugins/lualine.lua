return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        section_separators = "",
        component_separators = "",
        ignore_focus = { "NvimTree" },
        disabled_filetypes = {
          statusline = { "NvimTree" },
        },
        refresh = {
          statusline = 100,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "vim.fn.reg_recording()" },
        lualine_c = { "filename" },
        lualine_x = {
          "require('lsp-status').status()",
          "encoding",
          {
            "fileformat",
            symbols = { dos = "dos", unix = "unix", mac = "mac" },
          },
          {
            "filetype",
            colored = false,
          },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
