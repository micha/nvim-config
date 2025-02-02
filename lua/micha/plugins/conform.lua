return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        python = {
          "isort",
          "black",
          "ruff_format",
        },
      },
      ---@diagnostic disable-next-line: unused-local
      format_on_save = function(bufnr)
        if vim.fn.filereadable(".enable-format-on-save") then
          return {
            lsp_fallback = true,
            async = false,
            timeout_ms = 1000,
          }
        end
      end,
    })

    vim.keymap.set({ "n", "v" }, "<leader>F", function()
      conform.format({
        lsp_fallback = true,
        async = true,
      })
    end, { desc = "Format" })
  end,
}
