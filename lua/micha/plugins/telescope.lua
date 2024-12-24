return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "AckslD/nvim-neoclip.lua",
  },
  config = function()
    local u = require("micha.util")
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")

    -- or create your custom action
    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,

      select_all_hidden = function(prompt_bufnr)
        local action_state = require("telescope.actions.state")
        local action_utils = require("telescope.actions.utils")
        local current_picker = action_state.get_current_picker(prompt_bufnr)
        local orig_row = current_picker:get_selection_row()

        action_utils.map_entries(prompt_bufnr, function(entry, index, row)
          if u.buf_is_hidden(entry.bufnr) then
            current_picker:set_selection(row)
            actions.add_selection(prompt_bufnr)
          end
        end)

        current_picker:set_selection(orig_row)
      end,

      delete_selected_buffers = function(prompt_bufnr)
        local action_utils = require("telescope.actions.utils")

        action_utils.map_selections(prompt_bufnr, function(entry, index)
          vim.api.nvim_buf_delete(entry.bufnr, {})
        end)
      end,

      goto_buffers = function(prompt_bufnr)
        local prompt = require("telescope.actions.state").get_current_line()
        require("telescope.builtin").buffers({ default_text = prompt })
      end,

      goto_find_files = function(prompt_bufnr)
        local prompt = require("telescope.actions.state").get_current_line()
        require("telescope.builtin").find_files({ default_text = prompt })
      end,

      goto_live_grep = function(prompt_bufnr)
        local prompt = require("telescope.actions.state").get_current_line()
        require("telescope.builtin").live_grep({ default_text = prompt })
      end,

      doit = function(prompt_bufnr)
        local current_picker = action_state.get_current_picker(prompt_bufnr)
      end,
    })

    telescope.setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
        fzf = {},
      },

      pickers = {
        buffers = {
          select_current = true,
          sort_lastused = true,
          mappings = {
            n = {
              ["<C-h>"] = custom_actions.select_all_hidden,
              ["<C-d>"] = actions.delete_buffer,
            },
            i = {
              ["<C-h>"] = custom_actions.select_all_hidden,
              ["<C-d>"] = actions.delete_buffer,
            },
          },
        },
      },

      defaults = {
        path_display = { "smart" },
        dynamic_preview_title = true,
        mappings = {
          n = {
            ["<C-a>"] = actions.select_all,
            ["<C-u>"] = actions.toggle_all,
            ["<C-f>"] = actions.preview_scrolling_down,
            ["<C-b>"] = actions.preview_scrolling_up,
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-t>"] = actions.select_tab,
            ["<localleader>b"] = custom_actions.goto_buffers,
            ["<localleader>f"] = custom_actions.goto_find_files,
            ["<localleader>s"] = custom_actions.goto_live_grep,
          },
          i = {
            ["<C-a>"] = actions.select_all,
            ["<C-u>"] = actions.toggle_all,
            ["<C-f>"] = actions.preview_scrolling_down,
            ["<C-b>"] = actions.preview_scrolling_up,
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-t>"] = actions.select_tab,
            ["<localleader>b"] = custom_actions.goto_buffers,
            ["<localleader>f"] = custom_actions.goto_find_files,
            ["<localleader>s"] = custom_actions.goto_live_grep,
            -- ["<C-t>"] = trouble_telescope.open,
          },
        },
      },
    })

    -- Enable Telescope extensions if they are installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")
    pcall(require("telescope").load_extension, "neoclip")
    pcall(require("telescope").load_extension, "notify")

    -- See `:help telescope.builtin`
    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>fb", "<cmd>Telescope builtin<cr>", { desc = "Telescope builtins" })
    vim.keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "String under cursor" })
    vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
    vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Files in project" })
    vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
    vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
    vim.keymap.set("n", "<leader>fQ", "<cmd>Telescope quickfixhistory<cr>", { desc = "Quickfix history" })
    vim.keymap.set("n", "<leader>fq", "<cmd>Telescope quickfix<cr>", { desc = "Quickfix" })
    vim.keymap.set("n", "<leader>fr", "<cmd>Telescope resume<cr>", { desc = "Resume search" })
    vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "String in project" })
    vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Todos" })
    vim.keymap.set("n", "<leader>fp", function()
      builtin.find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") })
    end, { desc = "Neovim plugins" })
    vim.keymap.set("n", "<leader>fm", "<cmd>Telescope macroscope<cr>", { desc = "Macros" })
    vim.keymap.set("n", "<leader>f.", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
    vim.keymap.set("n", "<leader><leader>", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set("n", "<leader>/", function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        -- winblend = 10,
        previewer = false,
      }))
    end, { desc = "Find in current buffer" })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set("n", "<leader>f/", function()
      builtin.live_grep({
        grep_open_files = true,
      })
    end, { desc = "Open files" })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set("n", "<leader>fn", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "Neovim files" })
  end,
}
