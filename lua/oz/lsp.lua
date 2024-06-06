local lsp_ok, lsp = pcall(require, "lspconfig")
local mason_ok, mason = pcall(require, "mason")
local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")

if not lsp_ok or not mason_lsp_ok or not mason_ok then
  print "lspconfig or mason or masonlsp is not installed"
  return
end

local servers = {
  "lua_ls",
  "rust_analyzer",
  "pyright",
  "docker_compose_language_service",
  "tsserver",
  "gopls",
  "html",
  "volar",
}
local capabilities = require("cmp_nvim_lsp").default_capabilities()

mason.setup()
mason_lsp.setup({
    ensure_installed = servers
})

local commonOptions = {capabilities = capabilities}

lsp.lua_ls.setup(commonOptions)
lsp.rust_analyzer.setup(commonOptions)
lsp.tsserver.setup(commonOptions)
lsp.docker_compose_language_service.setup(commonOptions)
lsp.gopls.setup(commonOptions)
lsp.html.setup(commonOptions)
lsp.volar.setup(commonOptions)
-- https://github.com/astral-sh/ruff-lsp
lsp.ruff_lsp.setup({
  on_attach = function(client, bufnr)
    if client.name == 'ruff_lsp' then
      client.server_capabilities.incomingCells = false
    end
  end,
  capabilities = capabilities
})


lsp.pyright.setup({
  capabilities=capabilities,
  settings = {
    pyright = {
      disableOrganizeImports = true
    },
    python = {
      analysis = {
        ignore = { '*' }
      }
    }
  }
})
