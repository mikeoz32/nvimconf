local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local M = {}


function M.envs_picker(opts)
  local venv = require("ozvim.py.venv")
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Hatch Envs",
    sorter = conf.generic_sorter(opts),

    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local env_name = action_state.get_selected_entry()[1]
        venv.activate_venv({ env_name = env_name })
        vim.notify("Venv " .. tostring(env_name) .. " activated")
      end)
      return true
    end,
    finder = finders.new_table({
      results = venv.get_env_names(),
      push_cursor_on_edit = true,
      push_tagstack_on_edit = true,
    }),
  }):find()
end

function M.setup()
  vim.api.nvim_create_user_command("HatchEnv", M.envs_picker, {})
end

return M
