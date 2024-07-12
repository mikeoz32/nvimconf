local has_telescope, telescope = pcall(require, "telescope")

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local json = require("json")

local M = {}

local environments = {}
local active_env = nil

local function load_environments(callback)
  vim.system({ "hatch", "env", "show", "--json" }, { cwd = vim.uv.cwd() }, function(obj)
    local env_info = json.decode(obj.stdout)

    for k, env in pairs(env_info) do
      if env.type ~= "virtual" then
        vim.system({ "hatch", "env", "find", k }, { cwd = vim.uv.cwd() }, function(venv_path)
          environments[k] = vim.tbl_deep_extend('force', env_info[k], { path = venv_path.stdout:gsub("\r\n", "") })
          local env_names = M.get_env_names()
          if #vim.tbl_keys(environments) == #env_names then
            vim.schedule_wrap(callback)()
          end
        end)
      end
    end
  end)
end

local function setup_default_environment()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client == nil then
        return
      end
      if client and client.name == "pyright" then
        if client.settings then
          client.settings = vim.tbl_deep_extend("force", client.settings,
            { pythonPath = environments[active_env].path })
        end
        client.notify('workspace/didChangeConfiguration', { settings = nil })
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
      if client.settings then
        client.settings = vim.tbl_deep_extend("force", client.settings,
          { pythonPath = environments[env_name].path })
      end
      client.notify('workspace/didChangeConfiguration', { settings = nil })
      active_env = env_name
    end
  end
end

function M.get_scripts()
  local scripts = {}
  for env, env_conf in pairs(environments) do
    if env_conf.scripts then
      for name, _ in pairs(env_conf.scripts) do
        table.insert(scripts, {
          env = env,
          name = name
        })
      end
    end
  end

  return scripts
end

-- Pickers

local function hatch_envs_picker(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Hatch Envs",
    sorter = conf.generic_sorter(opts),

    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local env_name = action_state.get_selected_entry()[1]
        M.activate_venv({ env_name = env_name })
        vim.notify("Venv " .. tostring(env_name) .. " activated")
      end)
      return true
    end,
    finder = finders.new_table({
      results = M.get_env_names(),
      push_cursor_on_edit = true,
      push_tagstack_on_edit = true,
    }),
  }):find()
end

local function create_script_terminal(opts)
  local Terminal = require("toggleterm.terminal").Terminal
  return Terminal:new({
    cmd = "hatch run " .. opts.env .. ":" .. opts.name,
    dir = vim.uv.cwd(),
    direction = "float",
    hidden = true,
    close_on_exit = false,
    on_open = function(term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
  })
end

local function hatch_scripts_picker(opts)
  opts = opts or {}

  pickers.new(opts, {
    prompt_title = "Hatch Scripts",
    sorter = conf.generic_sorter(opts),

    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local script = action_state.get_selected_entry()

        local script_terminal = create_script_terminal(script.value)
        script_terminal:open()
      end)
      return true
    end,
    finder = finders.new_table({
      results = M.get_scripts(),
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.env .. "-" .. entry.name,
          ordinal = entry.env .. "-" .. entry.name
        }
      end,
      push_cursor_on_edit = true,
      push_tagstack_on_edit = true,
    }),
  }):find()
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

local function setup_telescope()
  if not has_telescope then
    return
  end

  vim.api.nvim_create_user_command("HatchEnv", hatch_envs_picker, {})
  vim.api.nvim_create_user_command("HatchScripts", hatch_scripts_picker, {})
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

function M.setup(opts)
  opts = opts or {}

  local on_load = opts.on_load or function() end
  active_env = opts.default_env or "default"
  load_environments(function()
    setup_default_environment()
    setup_telescope()
    on_load()
  end)
end

return M
