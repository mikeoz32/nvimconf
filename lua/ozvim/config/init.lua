local toml = require("toml")

_G.OzVim = require("ozvim.util")

--- Main configuration module
---
---@class OzVimConfig: OzVimOptions
local M = {}

OzVim.config = M


M.did_init = false

--- Initialize whole system
function M.init()
  if M.did_init then
    return
  end

  M.did_init = true
  --- Load options and merge them with defaults
  OzVim.options.setup()
  require("ozvim.project").setup()
  OzVim.lazy.setup()
  require("ozvim.py").setup()
  require("ozvim.config.keymap")
  OzVim.dbg(OzVim.expect_files_in_path({ "pyproject.toml" }))
end

function M.load_toml(path)
  local f = io.open(path, "r")
  if f then
    local data = f:read("*a")
    f:close()
    local parsed = toml.parse(data)
    return parsed or {}
  end
  return {}
end

return M
