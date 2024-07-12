local toml = require("toml")

local M = {}

function M.load(path)
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
