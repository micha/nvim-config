return {
  "AckslD/nvim-neoclip.lua",
  dependencies = {
    { "kkharji/sqlite.lua", module = "sqlite" },
    -- you'll need at least one of these
    { "nvim-telescope/telescope.nvim" },
    -- {'ibhagwan/fzf-lua'},
  },
  config = function()
    local handlers = require("neoclip.handlers")

    local function is_whitespace(line)
      return vim.fn.match(line, [[^\s*$]]) ~= -1
    end

    local function all(tbl, check)
      for _, entry in ipairs(tbl) do
        if not check(entry) then
          return false
        end
      end
      return true
    end

    ---Get user input and yank to the specified register.
    ---@param opts any
    local function set_register(opts)
      local r = nil
      if pcall(function()
        r = vim.fn.input("Yank to register")
      end) then
        if r == "" then
          r = '"'
        end
        if r ~= nil then
          if string.len(r) > 1 then
            vim.api.nvim_err_write("Invalid register name: '" .. r .. "'\n")
          else
            local status, error = pcall(function()
              handlers.set_registers({ r }, opts.entry)
              vim.print("Yanked to register " .. r)
            end)
            if error ~= nil then
              vim.api.nvim_err_write(error .. "\n")
            end
          end
        end
      end
    end

    require("neoclip").setup({
      enable_persistent_history = false,
      filter = function(data)
        return not all(data.event.regcontents, is_whitespace)
      end,
      keys = {
        telescope = {
          i = {
            select = "<TAB>",
            paste = "<CR>",
            paste_behind = "<c-CR>",
            replay = "<c-r>", -- replay a macro
            delete = "<c-d>", -- delete an entry
            edit = "<c-e>", -- edit an entry
            custom = {
              ["<c-y>"] = set_register,
            },
          },
          n = {
            select = "<TAB>",
            paste = "<CR>",
            --- It is possible to map to more than one key.
            -- paste = { 'p', '<c-p>' },
            paste_behind = "<c-CR>",
            replay = "r",
            delete = "d",
            edit = "e",
            custom = {
              ["<c-y>"] = set_register,
            },
          },
        },
      },
    })
  end,
}
