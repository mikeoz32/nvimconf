local servers = {
  "lua_ls",
  -- "rust_analyzer",
  "pyright",
  "docker_compose_language_service",
  "ts_ls",
  "gopls",
  "html",
  "vue_ls",
  "tailwindcss",
  "ruff",
  "elixirls",
  "emmet_language_server",
  "omnisharp",
  "jdtls",
}

return {
  "mason-org/mason-lspconfig",
  dependencies = {
    "mason.nvim"
  },
  config = function(_, opts)
    require('mason-lspconfig').setup({ ensure_installed = servers, automatic_enable = true })
  end
  -- config = true,
  -- init = function()
  --   local lsp = require("lspconfig")
  --   local capabilities = require("cmp_nvim_lsp").default_capabilities()
  --
  --   local commonOptions = { capabilities = capabilities }
  --
  --   lsp.lua_ls.setup({
  --     capabilities = capabilities,
  --     settings = {
  --       workspace = {
  --         library = vim.api.nvim_get_runtime_file("", true)
  --       },
  --       diagnostics = {
  --         -- Get the language server to recognize the `vim` global
  --         globals = { "vim" },
  --       },
  --     }
  --   })
  --   lsp.rust_analyzer.setup(commonOptions)
  --   lsp.tsserver.setup(commonOptions)
  --   lsp.docker_compose_language_service.setup(commonOptions)
  --   lsp.gopls.setup(commonOptions)
  --   lsp.html.setup(commonOptions)
  --   lsp.volar.setup(commonOptions)
  --   lsp.elixirls.setup(commonOptions)
  --   -- https://github.com/astral-sh/ruff-lsp
  --   lsp.ruff_lsp.setup({
  --     on_attach = function(client, bufnr)
  --       if client.name == 'ruff_lsp' then
  --         client.server_capabilities.incomingCells = false
  --       end
  --     end,
  --     capabilities = capabilities
  --   })
  --
  --
  --   lsp.pyright.setup({
  --     capabilities = capabilities,
  --     settings = {
  --       pyright = {
  --         disableOrganizeImports = true
  --       },
  --       python = {
  --         analysis = {
  --           ignore = { '*' }
  --         }
  --       }
  --     }
  --   })
  -- end
}
