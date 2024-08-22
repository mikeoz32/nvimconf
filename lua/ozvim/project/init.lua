-- Project module tries to guess what capabilities should be enabled for folder
-- First it tries to get infor from options next compare capability files lists with
-- folder contents

Capability = {
  is_active = false,
  files = {},
  name = nil
}

function Capability:new(opts)
  local obj = {}
  obj.files = opts.files or self.files or {}
  obj.name = opts.name or self.name -- TODO: check nil and raise
  setmetatable(obj, self)
  self.__index = self
  return obj
end

function Capability:setup()
  if OzVim.expect_files_in_path(self.files) and self.do_check() then
    self.is_active = true
  end

  return self.is_active
end

function Capability:do_check()
  return true
end

local GitCapability = Capability:new({ name = "git", files = { ".git" } })

function GitCapability:do_check()
  vim.notify("looking up for git executable")
  if vim.fn.executable("git") then
    vim.notify("Git found")
    return true
  end
  return false
end

local HatchCapability = Capability:new({ name = "hatch", files = { "pyproject.toml" } })

function HatchCapability:do_check()
  if not require("ozvim.py.pyproject").is_hatch() then
    return false
  end
  vim.notify("looking up for hatch executable")
  if vim.fn.executable("hatch") then
    vim.notify("Hatch found")
    return true
  end
  return false
end

local M = {
  -- Projects could have multiple capabilities, like .git support, python and python specific
  -- or frontend and backend applications
  capabilities = {
    -- Capability:new({ name = "git", files = { ".git" } }),
    GitCapability,
    Capability:new({ name = "python", files = { "setup.py", "setup.cfg", "pyproject.toml" } }),
    HatchCapability
  }
}

function M.capable(name)
  for _, cap in ipairs(M.capabilities) do
    if cap.name == name and cap.is_active then
      vim.notify("Project capability detected " .. name)
      return true
    end
  end
  return false
end

function M.names()
  local names = {}
  for _, cap in ipairs(M.capabilities) do
    if cap.is_active then
      table.insert(names, cap.name)
    end
  end

  return names
end

function M.setup(opts)
  for _, cap in ipairs(M.capabilities) do
    vim.notify("setting up capability " .. cap.name)
    cap:setup()
  end
end

return M
