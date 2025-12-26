local function volar_plugin()
  -- Якщо користувач задав $MASON, поважаємо його; інакше стандартний data dir
  local base = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
  local path = base .. "/packages/" .. "vue-language-server"
  return path .. '/node_modules/@vue/language-server'
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
    --   vim.lsp.config("lua_ls", opts['servers']['lua_ls'])
    --
    --   vim.lsp.config("pyright", {
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
    --
    --   vim.lsp.enable("ruff")
    --   -- on_attach = function(client, _)
    --   --   if client.name == 'ruff' then
    --   --     client.server_capabilities.incomingCells = false
    --   --   end
    --   -- end
    --   -- })
    --
    --   vim.lsp.enable("emmet_language_server")
    --
    --   vim.lsp.config("elixirls", {
    --     -- cmd = { "elixir-ls.cmd" }
    --   })
    --
    --   vim.lsp.config("tailwindcss", {
    --     filetypes = { "html", "elixir", "eelixir", "heex" },
    --     init_options = {
    --       userLanguages = {
    --         elixir = "html-eex",
    --         eelixir = "html-eex",
    --         heex = "html-eex"
    --       }
    --     }
    --   })
    --
    --   vim.lsp.config("html", {
    --     filetypes = { "html", "j2" }
    --   })
    --
    --   -- vim.lsp.config("ts_ls", {
    --   --   init_options = {
    --   --     plugins = {
    --   --       {
    --   --         name = '@vue/typescript-plugin',
    --   --         languages = { 'vue' },
    --   --         configNamepage = "typescript",
    --   --       },
    --   --     },
    --   --   },
    --   --   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    --   -- })
    --
    --   -- require("lspconfig")["omnisharp"].setup({})
    --   -- vim.lsp.config("vue_ls", {})
    --   --
    --   vim.lsp.enable("ts_ls")
    --   vim.lsp.enable("vue_ls")
    --
    --
    --   vim.lsp.config("jdtls", {
    --     settings = {
    --       java = {
    --         configuration = {
    --           runtimes = {
    --             {
    --               name = "JDK 17",
    --               path = "c:\\Programm Files\\Microsoft\\jdk-17.0.6.10-hotspot\\bin",
    --               default = true
    --             }
    --           }
    --         }
    --       }
    --     }
    --   })
    --
    --   vim.lsp.config("gopls", {
    --     {
    --       gofumpt = true,
    --       codelenses = {
    --         gc_details = false,
    --         generate = true,
    --         regenerate_cgo = true,
    --         run_govulncheck = true,
    --         test = true,
    --         tidy = true,
    --         upgrade_dependency = true,
    --         vendor = true,
    --       },
    --       hints = {
    --         assignVariableTypes = true,
    --         compositeLiteralFields = true,
    --         compositeLiteralTypes = true,
    --         constantValues = true,
    --         functionTypeParameters = true,
    --         parameterNames = true,
    --         rangeVariableTypes = true,
    --       },
    --       analyses = {
    --         fieldalignment = true,
    --         nilness = true,
    --         unusedparams = true,
    --         unusedwrite = true,
    --         useany = true,
    --       },
    --       usePlaceholders = true,
    --       completeUnimported = true,
    --       staticcheck = true,
    --       directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
    --       semanticTokens = true,
    --     }
    --   })
    --
    --   vim.lsp.config("zls", {})
    --
    vim.filetype.add {
      extension = {
        jinja = 'jinja',
        jinja2 = 'jinja',
        j2 = 'html',
      },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        vim.lsp.buf.format({ async = false })
      end
    })
  end
}
