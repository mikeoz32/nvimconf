local has_telescope, telescope = pcall(require, "telescope")
local pyproject = require("ozvim.py.pyproject")
local ts = require("ozvim.py.telescope")
local M = {}

M.env_info = {}

function M.setup()
  local expectations = OzVim.expect_files_in_path(project_files)

  -- if vim.tbl_count(expectations) == 0 then
  --   return
  -- end

  vim.notify("Python prjoect detected")

  pyproject.setup()
  if pyproject.is_hatch() then
    require("ozvim.py.hatch").setup()
  end
  require("ozvim.py.venv").setup({
    project_type = pyproject.project_type()
  })

  require("ozvim.py.telescope").setup()
end

return M
