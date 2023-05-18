local lsp_ok, lsp = pcall(require, "lspconfig")
local mason_ok, mason = pcall(require, "mason")
local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")

if not lsp_ok or not mason_lsp_ok or not mason_ok then
  print "lspconfig or mason or masonlsp is not installed"
  return
end

local servers = {"lua_ls", "rust_analyzer", "pyright","docker_compose_language_service", "tsserver", "gopls"}
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
lsp.pyright.setup(commonOptions)
lsp.gopls.setup(commonOptions)
