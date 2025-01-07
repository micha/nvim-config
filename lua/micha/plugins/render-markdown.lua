return {
  "MeanderingProgrammer/render-markdown.nvim",
  -- if you use the mini.nvim suite
  -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
  -- if you use standalone mini plugins
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
  -- if you prefer nvim-web-devicons
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    heading = {
      -- position = "inline",
      border = true,
      border_virtual = true, -- extra vertical space around heading
      width = "full",
      -- left_pad = 0.5, -- centered
    },
    -- Uncomment to disable anti-conceal
    -- --------------8<-----------------
    -- anti_conceal = {
    --   enabled = false,
    -- },
    -- win_options = {
    --   concealcursor = {
    --     rendered = "nc",
    --   },
    -- },
    -- -------------->8-----------------
    -- injections = {
    --   python = {
    --     enabled = true,
    --     query = [[
    --       ((function_definition
    --         body: (block
    --           .
    --           (expression_statement
    --             (string
    --               (string_content) @injection.content))))
    --         (#set! injection.language "markdown"))
    --     ]],
    --   },
    -- },
  },
  -- keys = {
  --   { "<localleader><localleader>", "<CMD>RenderMarkdown toggle<CR>", desc = "Toggle markdown rendering" },
  -- },
}
