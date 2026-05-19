--------------------------------------------------------------------------------
--- HELPERS
--------------------------------------------------------------------------------

-- {{{
local function default(t1, t2)
  for k, v in pairs(t2) do t1[k] = v end
  return t1
end

local function has(haystack, needle)
  for _, value in ipairs(haystack) do
    if value == needle then
      return true
    end
  end
end

local function remove(xs, x)
  local result = {}
  for i = 1, #xs do
    if xs[i] ~= x then table.insert(result, xs[i]) end
  end
  return result
end

local function prev_ws()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  if col == 0 then return true end
  local line = vim.api.nvim_get_current_line()
  local char = line:sub(col, col)
  return char:match("%s") ~= nil
end

local function vselected()
  local mode = vim.api.nvim_get_mode().mode
  local pos1 = vim.fn.getpos("v")
  local pos2 = vim.fn.getpos(".")
  local region = vim.fn.getregion(pos1, pos2, { type = mode })
  return table.concat(region, "\n")
end

local function toggle_opt_value(opt, value)
  if vim.tbl_contains(vim.opt[opt]:get(), value) then
    vim.opt[opt]:remove(value)
    print(opt .. ': removed ' .. value)
  else
    vim.opt[opt]:append(value)
    print(opt .. ': appended ' .. value)
  end
end

local group = vim.api.nvim_create_augroup('MyGroup', { clear = true })

local function autocmd(event, desc, pattern, callback)
  if not callback then
    callback = pattern
    pattern = nil
  end
  vim.api.nvim_create_autocmd(event, {
    group = group,
    desc = desc,
    pattern = pattern,
    callback = callback,
  })
end

local function map(mode)
  return function(lhs, desc, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, default({ desc = desc, remap = false, silent = true }, opts or {}))
  end
end

local imap = map('i')
local nmap = map('n')
local tmap = map('t')
local vmap = map('v')

local function plugin(...)
  local args = { n = select("#", ...), ... }
  local repo = args[1]
  local spec = {}
  local setup, f, name, ok, module
  if args.n == 1 then
    setup = {}
  elseif args.n == 2 then
    if type(args[2]) == 'function' then f = args[2] else setup = args[2] end
  else
    setup = args[2]
    f = args[3]
  end
  if type(repo) == 'table' or string.find(repo, '/') then
    if type(repo) == 'table' then
      if repo.name then spec.name = repo.name end
      if repo.version then spec.version = repo.version end
      if repo.data then spec.data = repo.data end
      repo = repo[1]
    end
    name = spec.name or table.remove(vim.split(repo, '/')):gsub('%.git$', ''):gsub('%.nvim$', '')
    spec.src = 'https://github.com/' .. repo
    vim.pack.add({ spec })
    vim.cmd.packloadall()
  else
    name = repo:gsub('^nvim.', '')
    vim.cmd.packadd(repo)
  end
  if setup ~= false then ok, module = pcall(require, name) end
  if ok and setup and module.setup then module.setup(setup) end
  if f then f(ok and module or nil) end
end
-- }}}

--------------------------------------------------------------------------------
--- OPTIONS
--------------------------------------------------------------------------------

-- {{{
vim.g.mapleader                   = ' '       -- must define before plugins are loaded
vim.g.maplocalleader              = ','       -- must define before plugins are loaded
vim.g.omni_sql_default_compl_type = 'syntax'  -- otherwise need dbext plugin

vim.opt.termguicolors             = true
vim.opt.background                = 'dark'
vim.opt.number                    = true
vim.opt.relativenumber            = true
vim.opt.cursorline                = true
vim.opt.cursorcolumn              = true
vim.opt.cursorlineopt             = { 'number', 'screenline' }
vim.opt.wrap                      = false
vim.opt.scrolloff                 = 10
vim.opt.sidescrolloff             = 10

vim.opt.tabstop                   = 2
vim.opt.shiftwidth                = 2
vim.opt.softtabstop               = 2
vim.opt.expandtab                 = true
vim.opt.smartindent               = true
vim.opt.autoindent                = true

vim.opt.ignorecase                = true
vim.opt.smartcase                 = true
vim.opt.hlsearch                  = true
vim.opt.incsearch                 = true

vim.opt.signcolumn                = "yes"
vim.opt.colorcolumn               = "80"
vim.opt.showmatch                 = true
vim.opt.cmdheight                 = 0


vim.opt.pumblend                  = 0
vim.opt.pumborder                 = 'rounded'
vim.opt.winblend                  = 0
vim.opt.winborder                 = 'rounded'


vim.opt.lazyredraw                = true
vim.opt.synmaxcol                 = 300
vim.opt.fillchars                 = { eob = " " }
vim.opt.showtabline               = 1

vim.opt.list                      = true
vim.opt.listchars                 = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.backup                    = false
vim.opt.writebackup               = false
vim.opt.swapfile                  = false
vim.opt.undofile                  = true
vim.opt.updatetime                = 300
vim.opt.timeoutlen                = 500

vim.opt.autoread                  = true
vim.opt.autowrite                 = false
vim.opt.sessionoptions            = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.diffopt                   = "internal,filler,closeoff,indent-heuristic,inline:char,linematch:60,iwhiteall"

vim.opt.hidden                    = true
vim.opt.errorbells                = false
vim.opt.backspace                 = "indent,eol,start"
vim.opt.autochdir                 = false
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.selection                 = "inclusive"
vim.opt.mouse                     = "a"
vim.opt.modifiable                = true
vim.opt.encoding                  = "utf-8"
vim.opt.spelllang                 = "en"

vim.opt.foldmethod                = "expr"
vim.opt.foldexpr                  = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel                 = 99

vim.opt.splitbelow                = true
vim.opt.splitright                = true

vim.opt.wildmenu                  = true
vim.opt.wildmode                  = "longest:full,full"
vim.opt.autocomplete              = false
vim.opt.completeopt               = "menuone,noinsert,noselect,preview"


vim.opt.redrawtime                = 10000
vim.opt.maxmempattern             = 20000

require('vim._core.ui2').enable({
  msg = {
    targets = {
      bufwrite = 'msg',
      undo = 'msg',
    }
  },
})

local non_edit_file_types = {
  'help',
  'Outline',
  'nvim-undotree',
  'FTerm',
}

vim.cmd.colorscheme('encom')
-- }}}

--------------------------------------------------------------------------------
--- PLUGINS
--------------------------------------------------------------------------------

-- {{{ nvim.undotree

plugin('nvim.undotree', function(m)
  nmap('U', 'Toggle undotree', function() m.open() end)
end)

-- }}}
-- {{{ tokyonight.nvim

plugin('folke/tokyonight.nvim', function(m)
  m.setup({
    style = "night",
    styles = { sidebars = "transparent", floats = "transparent" },
    on_colors = function(colors)
      colors.bg_float = colors.none
      colors.bg_sidebar = colors.none
      colors.bg_statusline = colors.none
    end,
  })
  autocmd('ColorScheme', 'set tokyonight highlights', 'tokyonight*', function()
    vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#1a1b26" })
    vim.api.nvim_set_hl(0, "Folded", { bg = "#1a1b26", fg = "#7aa2f7" })
    vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#292e42" })
    vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = "#565f89" })
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#292e42" })
  end)
end)

-- }}}
-- {{{ which-key.nvim

plugin('folke/which-key.nvim', function(m)
  m.setup({
    preset = 'classic',
    icons = { mappings = false, keys = {} },
    spec = {
      { '<leader>f',  group = 'Find' },
      { '<leader>fl', group = 'LSP' },
      { '<leader>g',  group = 'Git' },
      { '<leader>gh', group = 'Hunk' },
      { '<leader>l',  group = 'LSP' },
      { '<leader>s',  group = 'Session' },
      { '<C-t>',      group = 'Tab' },
      { 'gr',         group = 'LSP' },
    }
  })
end)

-- }}}
-- {{{ nvim-treesitter

plugin('nvim-treesitter/nvim-treesitter', {}, function(m)
  m.install({
    'bash',
    'c',
    'clojure',
    'css',
    'diff',
    'dockerfile',
    'git_config',
    'git_rebase',
    'gitcommit',
    'gitignore',
    'html',
    'janet_simple',
    'javascript',
    'json',
    'kdl',
    'latex',
    'lua',
    'luadoc',
    'markdown',
    'markdown_inline',
    'query',
    'sql',
    'typescript',
    'vim',
    'vimdoc',
    'yaml',
  })
  autocmd('FileType', 'Start treesitter', function() pcall(vim.treesitter.start) end)
end)

-- }}}
-- {{{ nvim-treesitter-context

plugin 'nvim-treesitter/nvim-treesitter-context'

-- }}}
-- {{{ fzf-lua

plugin('ibhagwan/fzf-lua', function(m)
  m.setup({
    -- fzf_colors = true,
    fzf_colors = {
      ["fg+"] = { "fg", { "Title" } },
      ["bg+"] = { "bg", { "CursorLine" } },
      ["hl"] = { "fg", { "DiffDelete" } },
      ["hl+"] = { "fg", { "DiffDelete" } },
      ["nth"] = "strip",
      ["info"] = "-1",
      ["nomatch"] = "-1",
    },
    keymap = {
      builtin = {
        ["<F1>"]       = "toggle-help",
        ["<F2>"]       = "toggle-fullscreen",
        ["<F3>"]       = "toggle-preview-wrap",
        ["<F4>"]       = "toggle-preview",
        ["<F5>"]       = "toggle-preview-cw",
        ["<F6>"]       = "toggle-preview-behavior",
        ["<F7>"]       = "toggle-preview-ts-ctx", -- requires `nvim-treesitter-context`
        ["<F8>"]       = "preview-ts-ctx-dec",
        ["<F9>"]       = "preview-ts-ctx-inc",
        ["<S-Left>"]   = "preview-reset",
        ["<PageDown>"] = "preview-half-page-down",
        ["<PageUp>"]   = "preview-half-page-up",
        ["<Down>"]     = "preview-down",
        ["<Up>"]       = "preview-up",
      },
      fzf = {
        ["ctrl-z"] = "abort",
        ["ctrl-u"] = "unix-line-discard",
        ["ctrl-f"] = "half-page-down",
        ["ctrl-b"] = "half-page-up",
        ["ctrl-a"] = "beginning-of-line",
        ["ctrl-e"] = "end-of-line",
        ["alt-a"]  = "toggle-all",
        ["alt-g"]  = "first",
        ["alt-G"]  = "last",
      },
    },
    actions = {
      files = {
        true,
        ["alt-h"] = false,
        ["alt-H"] = m.actions.toggle_hidden,
      }
    },
    buffers = { ignore_current_buffer = true },
    files = { follow = true },
    previewers = { builtin = { treesitter = { context = { max_lines = 0 } } } },
    winopts = { backdrop = 100 },
  })
  nmap('<leader><leader>', 'Buffers', '<CMD>FzfLua buffers<CR>')
  nmap('<leader>fb', 'Builtins', '<CMD>FzfLua builtin<CR>')
  nmap('<leader>ff', 'Files', '<CMD>FzfLua files<CR>')
  nmap('<leader>fh', 'Help', '<CMD>FzfLua help_tags<CR>')
  nmap('<leader>fk', 'Keymaps', '<CMD>FzfLua keymaps<CR>')
  nmap('<leader>fL', 'Loclist', '<CMD>FzfLua loclist<CR>')
  nmap('<leader>fq', 'Quickfix', '<CMD>FzfLua quickfix<CR>')
  nmap('<leader>fc', 'Word', '<CMD>FzfLua grep_cword<CR>')
  nmap('<leader>fs', 'String', '<CMD>FzfLua live_grep<CR>')
  nmap('<leader>fr', 'Resume', '<CMD>FzfLua resume<CR>')
end)

-- }}}
-- {{{ lazydev.nvim

plugin 'folke/lazydev.nvim'

-- }}}
-- {{{ mason.nvim

plugin 'mason-org/mason.nvim'

-- }}}
-- {{{ lsp-status.nvim

plugin('nvim-lua/lsp-status.nvim', function(m)
  m.register_progress()
  m.config({
    indicator_separator = "",
    status_symbol = "",
    indicator_errors = "E",
    indicator_warnings = "W",
    indicator_info = "I",
    indicator_hint = "H",
  })
end)

-- }}}
-- {{{ nvim-lspconfig

plugin('neovim/nvim-lspconfig', function()
  vim.lsp.enable({
    -- lspconfig                      mason
    -- -----------------------------------------------
    'clojure_lsp',    --    clojure-lsp
    'coffeesense',    --    coffeesense-language-server
    'lua_ls',         --    lua-language-server
    'ts_ls',          --    typescript-language-server
    'pyright',        --    pyright
  })

  autocmd('LspAttach', 'LSP keymaps', function(e)
    local client = vim.lsp.get_client_by_id(e.data.client_id)
    local bufnr = e.buf
    local opts = { buffer = bufnr }
    local fzf = require('fzf-lua')

    if not client then return end

    vim.diagnostic.config({
      underline = true,
      focusable = false,
      severity_sort = true,
      update_in_insert = false,
      float = { source = 'if_many', border = 'rounded' },
      jump = { float = true },
    })

    vim.lsp.completion.enable(true, client.id, bufnr)
    vim.bo.complete = 'o'

    nmap('grd', 'vim.lsp.buf.definition()', function() vim.lsp.buf.definition() end)
    nmap('<leader>fld', 'Document diagnostics', function() fzf.diagnostics_document() end, opts)
    nmap('<leader>flD', 'Workspace diagnostics', function() fzf.diagnostics_workspace() end, opts)
    nmap('<leader>flr', 'References', function() fzf.lsp_references() end, opts)
    nmap('<leader>flt', 'Typedefs', function() fzf.lsp_typedefs() end, opts)
    nmap('<leader>fls', 'Document symbols', function() fzf.lsp_document_symbols() end, opts)
    nmap('<leader>flS', 'Workspace symbols', function() fzf.lsp_workspace_symbols() end, opts)
    nmap('<leader>fli', 'Implementations', function() fzf.lsp_implementations() end, opts)
  end)
end)

-- }}}
-- {{{ conform.nvim

plugin('stevearc/conform.nvim', function(m)
  m.setup({
    formatters_by_ft = {
      lua = { lsp_format = 'always' },
      python = { 'black', lsp_format = 'never' },
      javascript = { 'prettierd', lsp_format = 'never' },
      typescript = { 'prettierd', lsp_format = 'never' },
    },
  })
  nmap('<leader>F', 'Format', function() m.format() end)
end)

-- }}}
-- {{{ auto-session

plugin('rmagatti/auto-session', {}, function()
  nmap('<leader>sd', 'Delete',  '<CMD>AutoSession delete<CR>')
  nmap('<leader>sr', 'Restore', '<CMD>AutoSession restore<CR>')
  nmap('<leader>ss', 'Save',    '<CMD>AutoSession save<CR>')
end)

-- }}}
-- {{{ lazygit.nvim

plugin('kdheepak/lazygit.nvim', {}, function()
  nmap('<leader>gg', 'Open lazygit', '<CMD>LazyGit<CR>')
end)

-- }}}
-- {{{ mini.nvim

plugin('nvim-mini/mini.nvim', false, function()
  require('mini.ai').setup({})
  require('mini.files').setup({
    mappings = {
      go_in_plus = '<CR>',
      go_out = 'H',
      go_out_plus = 'h',
    },
    windows = {
      preview = true,
      width_preview = 80,
    },
  })
  require('mini.indentscope').setup({})
  require('mini.splitjoin').setup({})
  require('mini.surround').setup({})

  autocmd('FileType', 'Configure indentscope', function()
    if has(non_edit_file_types, vim.bo.filetype) then
      vim.b.miniindentscope_config = { symbol = '' }
    end
  end)

  nmap('<leader>E', 'File explorer', function() require('mini.files').open(vim.api.nvim_buf_get_name(0), true) end)
end)

-- }}}
-- {{{ lualine.nvim

plugin('nvim-lualine/lualine.nvim', function(m)
  m.setup({
    options = {
      theme = "auto",
      section_separators = "",
      component_separators = "",
      ignore_focus = remove(non_edit_file_types, "help"),
      disabled_filetypes = { statusline = remove(non_edit_file_types, "help") },
      always_show_tabline = false,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "vim.fn.reg_recording()" },
      lualine_c = {
        {
          "filename",
          newfile_status = true,
        },
      },
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
    tabline = {
      lualine_a = {
        { "tabs", mode = 2 },
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          "filename",
          newfile_status = true,
        },
      },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
  })
end)

-- }}}
-- {{{ gitsigns.nvim

plugin('lewis6991/gitsigns.nvim', function(m)
  local signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  }

  m.setup({
    signs = signs,
    signs_staged = signs,
    current_line_blame = true,
    current_line_blame_opts = { delay = 250, ignore_whitespace = true },
  })

  nmap(']h', 'Next hunk', function() m.nav_hunk('next') end)
  nmap('[h', 'Previous hunk', function() m.nav_hunk('prev') end)
  nmap('<leader>ghs', 'Stage', function() m.stage_hunk() end)
  nmap('<leader>ghr', 'Reset', function() m.reset_hunk() end)
  nmap('<leader>ghp', 'Preview', function() m.preview_hunk() end)
  nmap('<leader>gb', 'Toggle blame line', function() m.toggle_current_line_blame() end)
  nmap('<leader>gB', 'Blame line full', function() m.blame_line({ full = true }) end)
  nmap('<leader>gd', 'Diff view', '<CMD>DiffviewOpen<CR>')
  nmap('<leader>gw', 'Toggle whitespace', function() toggle_opt_value('diffopt', 'iwhiteall') end)
end)

-- }}}
-- {{{ nvim-autopairs

plugin('windwp/nvim-autopairs', function(m)
  m.setup({ check_ts = true })
end)

-- }}}
-- {{{ outline.nvim

plugin('hedyhli/outline.nvim', function(m)
  m.setup({
    outline_window = {
      position = "left",
      width = 30,
      relative_width = false,
    },
    symbol_folding = { autofold_depth = 2 },
    symbols = { filter = { default = { "Function", "Class" } } },
  })
  nmap('<leader>O', 'Outline', '<CMD>Outline<CR>')
end)

-- }}}
-- {{{ render-markdown.nvim

plugin('MeanderingProgrammer/render-markdown.nvim', function(m)
  m.setup({ heading = { border = true, width = "full" } })
end)

-- }}}
-- {{{ todo-comments.nvim

plugin('folke/todo-comments.nvim', {}, function(m)
  nmap(']t', 'Next todo comment', function() m.jump_next() end)
  nmap('[t', 'Previous todo comment', function() m.jump_prev() end)
end)

-- }}}
-- {{{ vim-gnupg

plugin 'jamessan/vim-gnupg'

-- }}}
-- {{{ FTerm.nvim

plugin('numToStr/FTerm.nvim', function()
  local ft = require("FTerm")
  local sendit = function(cr)
    local vs = vselected()
    ft.open()
    vim.fn.chansend(ft.get_job_id(), vs .. (cr and "\r" or ""))
  end
  nmap("<A-i>", "Toggle floating terminal", '<CMD>lua require("FTerm").toggle()<CR>')
  tmap("<A-i>", "Toggle floating terminal", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
  vmap("<A-p>", "Send selection to terminal with <CR>", function() sendit(true) end)
  vmap("<A-P>", "Send selection to terminal without <CR>", function() sendit(false) end)
end)

-- }}}
-- {{{ vim-coffee-script

plugin 'kchmck/vim-coffee-script'

-- }}}
-- {{{ vim-visual-multi

plugin('mg979/vim-visual-multi', {}, function()
  vim.g.VM_highlight_matches = 'hi! link Search MiniJump'
  vim.g.VM_Mono_hl = 'DiffText'
end)

-- }}}
-- {{{ vim-sexp

plugin('guns/vim-sexp', function()
  vim.g.sexp_filetypes = 'clojure,scheme,lisp,fennel,janet'
end)

-- }}}
-- {{{ vim-sexp-mappings-for-regular-people

plugin('tpope/vim-sexp-mappings-for-regular-people')

-- }}}
-- {{{ diffview.nvim

plugin('sindrets/diffview.nvim', function(m)
  m.setup({
    use_icons = false,
    enhanced_diff_hl = true,
  })
end)

-- }}}

--------------------------------------------------------------------------------
--- COMMANDS
--------------------------------------------------------------------------------

-- {{{
vim.cmd.colorscheme('encom')
-- }}}

--------------------------------------------------------------------------------
--- KEYMAPS
--------------------------------------------------------------------------------

-- {{{
nmap('ZZ', 'Quit', '<CMD>qa<CR>')
nmap('<C-h>', 'Window focus left', '<C-w><C-h>')
nmap('<C-j>', 'Window focus down', '<C-w><C-j>')
nmap('<C-k>', 'Window focus up', '<C-w><C-k>')
nmap('<C-l>', 'Window focus right', '<C-w><C-l>')
nmap('aj', 'Break line at cursor', 'i<CR><ESC>')
nmap('<C-c>', 'Hide search highlight', '<CMD>nohlsearch<CR>')
imap('<Tab>', 'Next completion', function() return prev_ws() and '<Tab>' or '<C-n>' end, { expr = true })
imap('<CR>', 'Accept completion', function() return vim.fn.pumvisible() == 0 and '<CR>' or '<C-y>' end, { expr = true })
imap('<S-Tab>', 'Previous completion', '<C-p>')
nmap('<leader>X', 'Destroy buffer', '<CMD>bd<CR>')
nmap('<leader>M', 'Messages', '<CMD>messages<CR>')
nmap('<leader>R', 'Redraw', '<CMD>redraw!<CR>')
nmap('<C-t><C-t>', 'New', '<Cmd>tabnew<CR>')
nmap('<C-t><C-x>', 'Close', '<Cmd>tabclose<CR>')
nmap('<C-t><C-o>', 'Close others', '<Cmd>tabonly<CR>')
nmap('<C-t><C-l>', 'Next', '<Cmd>tabnext<CR>')
nmap('<C-t><C-h>', 'Previous', '<Cmd>tabprevious<CR>')
nmap('<C-t>1', 'Goto tab 1', '<Cmd>1tabnext<CR>')
nmap('<C-t>2', 'Goto tab 2', '<Cmd>2tabnext<CR>')
nmap('<C-t>3', 'Goto tab 3', '<Cmd>3tabnext<CR>')
nmap('<C-t>4', 'Goto tab 4', '<Cmd>4tabnext<CR>')
nmap('<C-t>5', 'Goto tab 5', '<Cmd>5tabnext<CR>')
nmap('<C-t>6', 'Goto tab 6', '<Cmd>6tabnext<CR>')
nmap('<C-t>7', 'Goto tab 7', '<Cmd>7tabnext<CR>')
nmap('<C-t>8', 'Goto tab 8', '<Cmd>8tabnext<CR>')
nmap('<C-t>9', 'Goto tab 9', '<Cmd>9tabnext<CR>')
nmap('<C-t>>', 'Move right', '<Cmd>+tabmove<CR>')
nmap('<C-t><', 'Move left', '<Cmd>-tabmove<CR>')
-- }}}

--------------------------------------------------------------------------------
--- AUTOCMDS
--------------------------------------------------------------------------------

-- {{{
autocmd('TextYankPost', 'Highlight yanked text', function()
  vim.highlight.on_yank()
end)
-- }}}

-- vim: foldmethod=marker foldlevel=0
