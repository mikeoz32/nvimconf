local hatch = require("ozvim.py.hatch")

local environments = {}
local active_env = nil

local M = {}


local project_files = {
  "pyproject.toml",
  "setup.py",
  "requirements.txt"
}

local environments = {}

local function detect_virtual_env()
  local expectations = OzVim.find_in_path({ ".venv", "venv" })
  for _, env_path in ipairs(expectations) do
    env_path = env_path:gsub("/", "\\")
    environments["default"] = { path = env_path }
    OzVim.dbg("Found venv in project folder " .. env_path)
  end
end

local function update_lsp_client(client, env_name)
  local env = environments[env_name]
  if env and env.path then
    local path 
    if vim.fn.has("win32") == 1 then
      path = env.path .. "\\Scripts\\python.exe"
    else
      path = env.path .. "/bin/python"
    end

    if vim.fn.executable(path) then
      if client.settings then
        client.settings = vim.tbl_deep_extend("force", client.settings,
          { python = { pythonPath = path } })
      end
      client.notify('workspace/didChangeConfiguration', { settings = nil })
    end
  end
end

local function setup_default_environment()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client == nil then
        return
      end
      if client and client.name == "pyright" then
        update_lsp_client(client, active_env)
        vim.notify("Venv " .. active_env .. " activated")
      end
    end
  })
end

function M.activate_venv(opts)
  opts = opts or {}
  local env_name = opts.env_name or "default"

  local path = M.get_env_path(env_name)
  if path == nil then
    return
  end

  for _, client in ipairs(vim.lsp.get_clients()) do
    if client == nil then
      return
    end
    if client and client.name == "pyright" then
      update_lsp_client(client, env_name)
      active_env = env_name
    end
  end
end

function M.get_env_names()
  return vim.tbl_keys(environments)
end

function M.get_env_path(env)
  local environment = vim.tbl_get(environments, env)
  if environment ~= nil then
    if environment.path then
      return environment.path
    end
  end
  return nil
end

function M.get_active_env()
  return {
    function()
      return active_env
    end,
    cond = function()
      return type(active_env) == "string"
    end
  }
end

function M.get_active_env_path()
  return M.get_env_path(active_env)
end

function M.merge_envs(envs)
  environments = vim.tbl_deep_extend("force", environments, envs)
end

local defaults = {
  default_env = "default",
  project_type = "requirements"
}

function M.setup(opts)
  opts = vim.tbl_deep_extend("force", defaults, opts or {})
  active_env = opts.default_env
  detect_virtual_env()
  OzVim.dbg(opts.project_type)
  if opts.project_type == "hatch" then
    vim.notify("Found hatch project. Initializing")
    hatch.load_environments({
      on_load = function(envs)
        M.merge_envs(envs)
      end
    })
  end
  setup_default_environment()
end

return M
