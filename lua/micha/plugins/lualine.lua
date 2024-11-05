return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    --- Returns a string like "10/2 23/0 ..." of status counts (passed/failed),
    --- one for each neotest adapter currently loaded.
    local function neotest_status()
      local result = {}
      for _, id in ipairs(require("neotest").state.adapter_ids()) do
        local status = require("neotest").state.status_counts(id)
        if status ~= nil then
          table.insert(result, status.passed .. "/" .. status.failed)
        end
      end
      return table.concat(result, " ")
    end

    require("lualine").setup({
      options = {
        theme = "auto",
        section_separators = "",
        component_separators = "",
        ignore_focus = { "NvimTree", "neotest-summary" },
        disabled_filetypes = {
          statusline = { "NvimTree", "neotest-summary" },
        },
        refresh = {
          statusline = 100,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "vim.fn.reg_recording()" },
        lualine_c = {
          {
            "filename",
            newfile_status = true,
            path = 1,
            shorting_target = 40,
          },
        },
        lualine_x = {
          {
            neotest_status,
            color = function(section) ---@diagnostic disable-line: unused-local
              if string.match(neotest_status() or "", "/[1-9]") then
                return { fg = "red" }
              end
            end,
          },
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
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "filename",
            newfile_status = true,
            path = 1,
            shorting_target = 40,
          },
        },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
