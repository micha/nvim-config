local m = {}

---Returns true if bufnr is hidden/unloaded (ie. not visible in any window).
---@param bufnr number
function m.buf_is_hidden(bufnr)
  local info = vim.fn.getbufinfo(bufnr)[1]
  return (info.hidden == 1 or info.loaded == 0)
end

return m
