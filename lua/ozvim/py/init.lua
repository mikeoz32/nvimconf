local has_telescope, telescope = pcall(require, "telescope")
local M = {}

M.env_info = {}


function M.setup()
  require("ozvim.py.hatch").setup()
end

return M
