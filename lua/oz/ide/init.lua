local toml = require("toml")
local v = vim.fn


local IDE = {}

Config = {}

local function _ensureInstalled (servers)
  local mLsp = require("mason-lspconfig")
  mLsp.setup({
    ensure_installed = servers
  })
end

function Config:new ()
  local o = {
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

  local language_servers = {}

  for lsp, conf in pairs(lsp_config) do
    local server = conf['language_server']
    if server ~= nil then
      table.insert(language_servers, server)
    end
  end
  _ensureInstalled(language_servers)
end

IDE.setup = function()
   -- local lines = v.readfile(v.stdpath("config") .. "/config.toml")
   local config = Config:new()
   config:load()
end

return IDE
