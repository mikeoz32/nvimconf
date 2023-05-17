local telescope = require("telescope")
local builtins = require("telescope.builtin")

local tele = {}

--- Open telescope against config directory
tele.search_in_config_dir = function ()
  config_path = vim.fn.stdpath('config')
  builtins.find_files({cwd = config_path})
end

tele.select_project = function ()
  telescope.extensions.projects.projects()
end

return tele
