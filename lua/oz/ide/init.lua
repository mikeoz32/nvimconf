local toml = require("toml")
local v = vim.fn


local IDE = {}


local function dbg(val)
  vim.api.nvim_echo({{vim.inspect(val)}}, true, {})
end

Config = {}

local default_global_options = {
  backup = false,
  clipboard = "unnamendplus",
  cmdheight = 2, -- height of nvim command status bar 

  completeopt = {"menuone", "noselect"}, -- for cmp
  conceallevel = 0, -- make `` visible in .md files
  fileencoding = "utf-8", -- file encoding
  hlsearch = true, -- highlight search
  ignorecase = true, -- ignore case in searches
  mouse = "a", -- allow mouse to be used in nvim
  pumheight = 10, -- pop up menu height
  showmode = false, -- did not show mode name in status bar
  showtabline = 2, -- alwais show tabs in header to be able to see what tab is currntly active
  smartcase = true, -- smart case
  smartindent = true, -- smart indent
  splitbelow = true, -- always split windows vertically below
  splitright = true,-- always split windows horizontally right
  swapfile = true, -- create swap file
  timeoutlen = 1000, -- time to wait for a mapped sequence to complete in milliseconds
  termguicolors = true, -- add more colors to nvim
  undofile = true, -- enable persisten undo
  updatetime = 300, -- default is 4000ms, make faster completions
  writebackup = false, -- just do not write any backups
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  cursorline = true, -- highlight current line
  number = true,-- show line number
  relativenumber = false, -- never show relative line numbers only absolute
  numberwidth = 2, -- set width of column that sshows line numbers to 2 instead of default 4
  signcolumn = "yes", -- show sign column
  wrap = fasle, -- never wrap lines
  scrolloff = 8,
  sidescrolloff = 8
}

local function _ensureInstalled (servers)
  local mason = require("mason")
  local mLsp = require("mason-lspconfig")
  mason.setup()
  local result = mLsp.setup({
    ensure_installed = servers
  })
  dbg(result)
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
   dbg(self.config)
end

function Config:apply_options()
  for option, value in pairs(default_global_options) do
    vim.opt[tostring(option)]=value
  end
end
-- Install packer if it is not installed

function Config:config_lsp()
  local lsp_config = self.config["lsp"]
  if  lsp_config == nil then
    return
  end

  local language_servers = {}

  for lsp, conf in pairs(lsp_config) do
    local server = conf['language-server']
    if server ~= nil then
      table.insert(language_servers, server)
    end
  end
  _ensureInstalled(language_servers)
end

IDE.setup = function()
   local config = Config:new()
   config:load()
   config:apply_options()
   config:config_lsp()
end

return IDE
