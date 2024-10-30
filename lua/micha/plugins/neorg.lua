return {
  "nvim-neorg/neorg",
  lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = "*", -- Pin Neorg to the latest stable release
  config = function()
    require("neorg").setup({
      load = {
        ["core.concealer"] = {},
        ["core.defaults"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/git/micha/notes",
            },
            default_workspace = "notes",
          },
        },
      },
    })

    vim.api.nvim_create_autocmd("Filetype", {
      pattern = "norg",
      callback = function()
        vim.opt.conceallevel = 3
        vim.opt.concealcursor = "nc"

        vim.keymap.set("n", "<localleader>r", function()
          -- Get all the buffers
          local buffers = vim.api.nvim_list_bufs()

          local to_delete = {}
          for buffer in vim.iter(buffers):rev() do
            if vim.fn.buflisted(buffer) == 1 then
              -- If the listed buffer we're working with has a .norg extension then remove it (not forcibly)
              if not vim.endswith(vim.api.nvim_buf_get_name(buffer), ".norg") then
                vim.api.nvim_win_set_buf(0, buffer)
                break
              else
                table.insert(to_delete, buffer)
              end
            end
          end

          for _, buffer in ipairs(to_delete) do
            vim.api.nvim_buf_delete(buffer, { force = true })
          end
        end, { buffer = true, desc = "Neorg return" })
      end,
    })
  end,
  keys = {
    { "<leader>nn", "<CMD>Neorg index<CR>", desc = "Neorg index" },
  },
}
