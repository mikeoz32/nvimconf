local Terminal = require("toggleterm.terminal").Terminal
local lazy_git = Terminal:new({
  cmd = "lazygit",
  hidden = true,
  direction = "float"
})

local base_term = Terminal:new({})

local Terminals = {}

Terminals.lazygit_toggle = function ()
  lazy_git:toggle()
end

Terminals.toggle_term = function ()
  base_term:toggle()
end

Terminals.setup = function ()
  
end

return Terminals
