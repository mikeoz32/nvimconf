local venv = require("ozvim.py.venv")
return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'python' },
      highlight = {
        enable = true
      }
    }
  },
  {
    "williamboman/mason-lspconfig",
    opts = {
      ensure_installed = { 'pyright', 'ruff_lsp' }
    }
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          enabled = true,
          analytics = {
            typeCheckingMode = "strict"
          }
        },
        ruff_lsp = {
          enabled = true
        }
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",

    dependencies = { 'nvim-tree/nvim-web-devicons', "folke/noice.nvim" },
    opts = {
      sections = {
        -- lualine_a = { "mode" },
        -- lualine_b = { "branch" },
        -- lualine_c = { "buffers" },
        lualine_x = { venv.get_active_env() }
      }
    }
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          runner = "pytest",
          -- python = ".venv/bin/python",
          python = function()
            local py = require("ozvim.py.venv")
            return py.get_active_env_path() .. '\\Scripts\\python.exe'
          end,
          pytest_discover_instances = true,
        },
      },
    },
  },
}
