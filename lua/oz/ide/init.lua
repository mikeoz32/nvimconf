local toml = require("toml")
local v = vim.fn


local IDE = {}

Config = {}

function Config:new ()
  o = {
    file_name = "config.toml",
    config = {}
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

function Config:load()
   local config_file = assert(io.open(v.stdpath("config") .. "/config.toml", "r"))
   local config_contents = config_file:read("*all")
   self.config = toml.parse(config_contents)
   self:config_lsp()
end

function Config:config_lsp()
  local lsp_config = self.config["lsp"]
  if  lsp_config == nil then
    return
  end

  for lsp, conf in pairs(lsp_config) do
    print(lsp)
    print(conf)
  end
end

IDE.setup = function()
   -- local lines = v.readfile(v.stdpath("config") .. "/config.toml")
   local config = Config:new()
   config:load()
end

return IDE
