local M = {}
local common_opts = { noremap = true, silent = true }
local map = vim.keymap.set

setmetatable(M, {
  --- Kinda magic methods, dynamically attaches to M modules from util files
  --- When trying to access to M.json will require "ozvim.util.json" and retruns it
  ---@param t
  ---@param k
  __index = function(t, k)
    t[k] = require("ozvim.util." .. k)
    return t[k]
  end
})

function M.is_win()
  return vim.uv.os_uname().sysname:find("windows") ~= nil
end

function M.key_map(modes, lhs, rhs, opts)
  map(modes, lhs, rhs, vim.tbl_deep_extend('force', common_opts, opts or {}))
end

function M.expect_files_in_path(files)
  local pattern = M.find_in_path(files)
  return #pattern > 0
end

function M.find_in_path(files)
  files = files or {}

  return vim.fs.find(files, { path = vim.uv.cwd() })
end

function M.dbg(val)
  vim.api.nvim_echo({ { vim.inspect(val) } }, true, {})
end

return M
