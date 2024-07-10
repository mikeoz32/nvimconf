local M = {}

M.version = "0.0.1-dev"

local defaults = {
  langs = {
    python = {
      enabled = false,
      lsp = "pyright"
    },
    lua = {
      enabled = true,
      lsp = "lua_ls"
    }
  }
}

local options


function M.setup(opts)
  options = vim.tbl_deep_extend("force", defaults, opts or {}) or {}
  M.load_config()
  M.init_lazy()
end

function M.init_lazy()
  require("lazy").setup("oz.plugins")
end

function M.load_config()
  local path = vim.fn.stdpath("config") .. "/config.json"
  local f = io.open(path, "r")
  if f then
    local data = f:read("*a")
    f:close()
    local ok, json = pcall(vim.json.decode, data, { luanil = { object = true, array = true } })
    if ok then
      options = vim.tbl_deep_extend("force", options, json or {})
    end
  end
end

return M
