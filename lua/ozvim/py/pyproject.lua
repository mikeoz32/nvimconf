local M = {}

local project = nil

function M.setup()
  local file_data = OzVim.toml.load(vim.fs.joinpath(vim.uv.cwd(), "pyproject.toml"))
  if file_data == nil then
    return
  end

  project = file_data

  -- OzVim.dbg(project)
  if not project then
    return false
  end

  return project
end

function M.is_hatch()
  if not project then
    if M.setup() == false then
      return
    end
  end

  if project["build-system"] then
    local backnd = project["build-system"]["build-backend"]
    if backnd then
      return backnd == "hatchling.build"
    end
  end
  return false
end

function M.project_type()
  if M.is_hatch() then
    return "hatch"
  end
  return "none"
end

return M
