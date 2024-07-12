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
          enabled = true
        },
        ruff_lsp = {
          enabled = true
        }
      },
    },
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
            local py = require("ozvim.py.hatch")
            return py.get_active_env_path() .. '/Scripts/python.exe'
          end,
          pytest_discover_instances = true,
        },
      },
    },
  },
}
