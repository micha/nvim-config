---@diagnostic disable: missing-fields
return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "night",
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(colors)
        colors.bg_float = colors.none
        colors.bg_sidebar = colors.none
        colors.bg_statusline = colors.none
      end,
    })
    vim.cmd("colorscheme tokyonight")
    vim.api.nvim_set_hl(0, "ColorColumn", { link = "SignColumn" })
    vim.api.nvim_set_hl(0, "Folded", { bg = "#1a1b26", fg = "#7aa2f7" })
    vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#292e42" })
    vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = "#565f89" })
  end,
}

-- return {
--     "slugbyte/lackluster.nvim",
--     lazy = false,
--     priority = 1000,
--     init = function()
--         -- vim.cmd.colorscheme("lackluster")
--         vim.cmd.colorscheme("lackluster-hack") -- my favorite
--         -- vim.cmd.colorscheme("lackluster-mint")
--     end,
-- }

-- return {
--   "catppuccin/nvim",
--   priority = 1000,
--   name = "catppuccin",
--   config = function()
--     require("catppuccin").setup({
--       flavour = "mocha",
--     })
--     vim.cmd("colorscheme catppuccin-mocha")
--   end,
-- }
