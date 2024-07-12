vim.uv = vim.uv or vim.loop


local M = {}

--- OzVim setup
---@param opts? OzVimConfig
function M.setup(opts)
  require("ozvim.config").init()
end

return M

