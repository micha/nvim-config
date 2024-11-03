return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "j-hui/fidget.nvim", opts = {} }, -- Useful status updates for LSP.
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      -- ui = {
      --   icons = {
      --     package_installed = "✓",
      --     package_pending = "➜",
      --     package_uninstalled = "✗",
      --   },
      -- },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "clojure_lsp",
        "cssls",
        "emmet_ls",
        "html",
        "lua_ls",
        "pylsp",
        "ts_ls",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "black", -- python formatter
        "debugpy",
        -- "eslint_d", -- js/ts linter
        "isort", -- python formatter
        "prettier", -- prettier formatter
        "ruff", -- python linter
        "stylua", -- lua formatter
      },
    })
  end,
}
