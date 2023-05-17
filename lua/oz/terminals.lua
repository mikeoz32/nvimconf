local Terminal = require("toggleterm.terminal").Terminal
local lazy_git = Terminal:new({
  cmd = "lazygit",
  hidden = true,
  direction = "float"
})

local Terminals = {}

Terminals.lazygit_toggle = function ()
  lazy_git:toggle()
end

return Terminals
