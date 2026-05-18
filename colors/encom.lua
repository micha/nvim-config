vim.cmd.highlight("clear")

if vim.fn.exists("syntax_on") == 1 then
  vim.cmd.syntax("reset")
end

vim.g.colors_name = "encom"

local function set(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

local p = {
  bg = "#030607",
  bg_alt = "#071013",
  bg_soft = "#0B171B",
  bg_lift = "#10232A",

  mono_1 = "#D5F6F7",
  mono_2 = "#B8D7DA",
  mono_3 = "#8FB2B8",
  mono_4 = "#5F7F86",
  mono_5 = "#304A50",

  cyan = "#00E6FF",
  cyan_hot = "#7CFAFF",
  blue = "#147CFF",
  amber = "#FFB84A",
  orange = "#FF6A1A",
  red = "#FF2F2F",
  green = "#52FF9F",

  selection = "#102A33",
  search_bg = "#3B2A08",
  search_fg = "#FFE7A3",
  separator = "#123F49",
  border_fg = "#D5F6F7",

  diff_bg_add = "#062018",
  diff_bg_change = "#1F1806",
  diff_bg_delete = "#220808",
}

-- Core editor chrome
set("Normal", { fg = p.mono_2, bg = p.bg })
set("NormalNC", { fg = p.mono_3, bg = p.bg })
set("NormalFloat", { fg = p.mono_2, bg = p.bg_alt })
set("FloatBorder", { fg = p.border_fg, bg = p.bg_alt })
set("FloatTitle", { fg = p.cyan, bg = p.bg_alt, bold = true })
set("WinSeparator", { fg = p.border_fg })
set("EndOfBuffer", { fg = p.bg })
set("NonText", { fg = p.mono_5 })
set("Whitespace", { fg = p.mono_5 })
set("SpecialKey", { fg = p.mono_5 })

set("Cursor", { fg = p.bg, bg = p.cyan_hot })
set("CursorLine", { bg = p.bg_soft })
set("CursorColumn", { bg = p.bg_soft })
pcall(set, "ColorColumn", { bg = p.bg })
set("LineNr", { fg = p.mono_5 })
set("CursorLineNr", { fg = p.border_fg, bold = true })
set("SignColumn", { bg = p.bg })
set("FoldColumn", { fg = p.mono_5, bg = p.bg })
set("Folded", { fg = p.mono_4, bg = p.bg_alt })

set("Visual", { bg = p.selection })
set("VisualNOS", { bg = p.selection })
set("Search", { fg = p.search_fg, bg = p.search_bg })
set("IncSearch", { fg = p.bg, bg = p.cyan_hot })
set("CurSearch", { fg = p.bg, bg = p.cyan_hot })
set("Substitute", { fg = p.red, bg = p.diff_bg_delete })
set("MatchParen", { fg = p.red, bg = p.diff_bg_delete, bold = true })

set("Pmenu", { fg = p.mono_2, bg = p.bg_alt })
set("PmenuBorder", { fg = p.border_fg, bg = p.bg_alt })
set("PmenuSel", { fg = p.bg, bg = p.cyan })
set("PmenuKind", { fg = p.mono_4, bg = p.bg_alt })
set("PmenuKindSel", { fg = p.bg, bg = p.cyan })
set("PmenuExtra", { fg = p.mono_4, bg = p.bg_alt })
set("PmenuExtraSel", { fg = p.bg, bg = p.cyan })
set("PmenuSbar", { bg = p.bg_lift })
set("PmenuThumb", { bg = p.cyan })

set("StatusLine", { fg = p.cyan, bg = p.bg_alt })
set("StatusLineNC", { fg = p.mono_4, bg = p.bg })
set("TabLine", { fg = p.mono_4, bg = p.bg })
set("TabLineFill", { bg = p.bg })
set("TabLineSel", { fg = p.cyan, bg = p.bg_alt, bold = true })

set("Question", { fg = p.cyan })
set("MoreMsg", { fg = p.green })
set("ModeMsg", { fg = p.cyan })
set("OkMsg", { fg = p.green })
set("WarningMsg", { fg = p.amber })
set("ErrorMsg", { fg = p.red })
set("Title", { fg = p.cyan_hot, bold = true })
set("Directory", { fg = p.cyan })

-- Code stays nearly monochrome; hue is reserved for editor state.
set("Comment", { fg = p.mono_4 })
set("Constant", { fg = p.mono_3 })
set("String", { fg = p.mono_4 })
set("Character", { fg = p.mono_4 })
set("Number", { fg = p.mono_4 })
set("Boolean", { fg = p.mono_4 })
set("Float", { fg = p.mono_4 })
set("Identifier", { fg = p.mono_2 })
set("Function", { fg = p.mono_2 })
set("Statement", { fg = p.mono_1 })
set("Conditional", { fg = p.mono_1 })
set("Repeat", { fg = p.mono_1 })
set("Label", { fg = p.mono_3 })
set("Operator", { fg = p.mono_4 })
set("Keyword", { fg = p.mono_1 })
set("Exception", { fg = p.mono_1 })
set("PreProc", { fg = p.mono_3 })
set("Include", { fg = p.mono_3 })
set("Define", { fg = p.mono_3 })
set("Macro", { fg = p.mono_3 })
set("PreCondit", { fg = p.mono_3 })
set("Type", { fg = p.mono_3 })
set("StorageClass", { fg = p.mono_3 })
set("Structure", { fg = p.mono_3 })
set("Typedef", { fg = p.mono_3 })
set("Special", { fg = p.mono_3 })
set("SpecialChar", { fg = p.mono_3 })
set("Tag", { fg = p.mono_3 })
set("Delimiter", { fg = p.mono_4 })
set("SpecialComment", { fg = p.mono_4, italic = true })
set("Debug", { fg = p.mono_3 })
set("Underlined", { fg = p.mono_1, underline = true })
set("Ignore", { fg = p.mono_5 })
set("Error", { fg = p.red })
set("Todo", { fg = p.bg, bg = p.cyan })

-- Diagnostics and VCS signs are intentionally saturated editor signals.
set("DiagnosticError", { fg = p.red })
set("DiagnosticWarn", { fg = p.amber })
set("DiagnosticInfo", { fg = p.cyan })
set("DiagnosticHint", { fg = p.blue })
set("DiagnosticOk", { fg = p.green })
set("DiagnosticUnderlineError", { sp = p.red, undercurl = true })
set("DiagnosticUnderlineWarn", { sp = p.amber, undercurl = true })
set("DiagnosticUnderlineInfo", { sp = p.cyan, undercurl = true })
set("DiagnosticUnderlineHint", { sp = p.blue, undercurl = true })
set("DiagnosticVirtualTextError", { fg = p.red, bg = p.bg_alt })
set("DiagnosticVirtualTextWarn", { fg = p.amber, bg = p.bg_alt })
set("DiagnosticVirtualTextInfo", { fg = p.cyan, bg = p.bg_alt })
set("DiagnosticVirtualTextHint", { fg = p.blue, bg = p.bg_alt })

set("Added", { fg = p.green })
set("Changed", { fg = p.amber })
set("Removed", { fg = p.red })
set("DiffAdd", { fg = p.green, bg = p.diff_bg_add })
set("DiffChange", { fg = p.amber, bg = p.diff_bg_change })
set("DiffDelete", { fg = p.red, bg = p.diff_bg_delete })
set("DiffText", { fg = p.cyan_hot, bg = p.selection })
set("GitSignsAdd", { fg = p.green })
set("GitSignsChange", { fg = p.amber })
set("GitSignsDelete", { fg = p.red })

-- Common plugin groups
set("MiniJump", { fg = p.search_fg, bg = p.search_bg })
set("MiniJump2dSpot", { fg = p.bg, bg = p.cyan_hot, bold = true })
set("MiniStatuslineModeNormal", { fg = p.bg, bg = p.cyan })
set("MiniStatuslineModeInsert", { fg = p.bg, bg = p.green })
set("MiniStatuslineModeVisual", { fg = p.bg, bg = p.blue })
set("MiniStatuslineModeReplace", { fg = p.bg, bg = p.red })
set("MiniStatuslineModeCommand", { fg = p.bg, bg = p.amber })
set("MiniStatuslineInactive", { fg = p.mono_4, bg = p.bg_alt })

set("TelescopeNormal", { fg = p.mono_2, bg = p.bg_alt })
set("TelescopeBorder", { fg = p.border_fg, bg = p.bg_alt })
set("TelescopePromptBorder", { fg = p.cyan, bg = p.bg_alt })
set("TelescopeSelection", { fg = p.cyan_hot, bg = p.selection })
set("TelescopeMatching", { fg = p.amber, bold = true })

set("WhichKey", { fg = p.cyan })
set("WhichKeyDesc", { fg = p.mono_2 })
set("WhichKeyGroup", { fg = p.blue })
set("WhichKeyBorder", { fg = p.border_fg })

vim.api.nvim_create_autocmd({ "TabNew", "ColorScheme" }, {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "lualine_a_tabs_inactive", { link = "DiffText" })
  end,
})

-- Tree-sitter captures
set("@comment", { link = "Comment" })
set("@constant", { link = "Constant" })
set("@string", { link = "String" })
set("@number", { link = "Number" })
set("@boolean", { link = "Boolean" })
set("@variable", { fg = p.mono_2 })
set("@variable.builtin", { fg = p.mono_3 })
set("@property", { fg = p.mono_3 })
set("@field", { fg = p.mono_3 })
set("@function", { link = "Function" })
set("@function.builtin", { fg = p.mono_3 })
set("@constructor", { fg = p.mono_3 })
set("@keyword", { link = "Keyword" })
set("@keyword.function", { link = "Keyword" })
set("@keyword.operator", { fg = p.mono_1 })
set("@operator", { link = "Operator" })
set("@punctuation", { fg = p.mono_4 })
set("@punctuation.bracket", { fg = p.mono_4 })
set("@punctuation.delimiter", { fg = p.mono_4 })
set("@type", { link = "Type" })
set("@tag", { fg = p.mono_3 })
set("@tag.attribute", { fg = p.mono_3 })
set("@tag.delimiter", { fg = p.mono_4 })
