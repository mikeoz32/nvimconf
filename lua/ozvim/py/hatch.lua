local has_telescope, telescope = pcall(require, "telescope")

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local json = require("json")

local M = {}

local environments = {}
-- local active_env = nil

local function load_environments(callback)
  vim.system({ "hatch", "env", "show", "--json" }, { cwd = vim.uv.cwd() }, function(obj)
    local env_info = json.decode(obj.stdout)

    for k, env in pairs(env_info) do
      if env.type ~= "virtual" then
        vim.system({ "hatch", "env", "find", k }, { cwd = vim.uv.cwd() }, function(venv_path)
          environments[k] = vim.tbl_deep_extend('force', env_info[k], { path = venv_path.stdout:gsub("\r\n", "") })
          -- chech does all environments are loaded?
          local env_names = M.get_env_names()
          if #vim.tbl_keys(environments) == #env_names then
            vim.schedule_wrap(callback)(environments)
          end
        end)
      end
    end
  end)
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

local function setup_telescope()
  if not has_telescope then
    return
  end

  vim.api.nvim_create_user_command("HatchScripts", hatch_scripts_picker, {})
end

local envs_loaded = false

function M.load_environments(opts)
  opts = opts or {}
  local force = opts.force or false
  local on_load = opts.on_load or function(_) end
  if envs_loaded == false or force == true then
    load_environments(on_load)
  else
    on_load(environments)
  end
end

function M.setup(opts)
  opts = opts or {}

  setup_telescope()
end

return M
