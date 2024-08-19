local function volar_plugin()
  local mason_registry = require('mason-registry')
  return mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'
end

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  event = "VeryLazy",

  opts = function()
    return {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              codeLens = {
                enable = true
              },
              workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
              },
            }
          }
        }
      }
    }
  end,

  config = function(_, opts)
    require("lspconfig")["lua_ls"].setup(opts['servers']['lua_ls'])

    require("lspconfig")["pyright"].setup({
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
    require("lspconfig")["ruff_lsp"].setup({
      on_attach = function(client, _)
        if client.name == 'ruff_lsp' then
          client.server_capabilities.incomingCells = false
        end
      end
    })

    require("lspconfig")["emmet_language_server"].setup({})
    require("lspconfig")["tailwindcss"].setup({})
    require("lspconfig")["html"].setup({
      filetypes = { "html", "j2" }
    })
    require("lspconfig")["omnisharp"].setup({})
    require("lspconfig")["volar"].setup({})
    require("lspconfig")["tsserver"].setup({
      init_options = {
        plugins = {
          {
            name = '@vue/typescript-plugin',
            location = volar_plugin(),
            languages = { 'vue' },
          },
        },
      },
      filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    })
    require("lspconfig")["gopls"].setup(
      {
        gofumpt = true,
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = {
          fieldalignment = true,
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
        semanticTokens = true,
      }
    )
    vim.filetype.add {
      extension = {
        jinja = 'jinja',
        jinja2 = 'jinja',
        j2 = 'html',
      },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        vim.lsp.buf.format()
      end
    })
  end
}
