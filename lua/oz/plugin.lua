local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTRSTAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "installing packer close and reopen nvim... "
  vim.cmd [[packadd packer.nvim]]
end

--- Autocommand that syncs all plugins when this file was changed
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugin.lua source <afile> | PackerSync
  augroup end
]]

-- Try to get packer
local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  print "Unable to load packer, check configuration and installation"
  return
end

-- Use popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = rounded }
    end
  }
}

return packer.startup(function(use)
  use "wbthomason/packer.nvim"
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"

  -- whichkey
  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end
  }

  -- completion
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/vim-vsnip"

  -- lsp
  use "neovim/nvim-lspconfig"
  use {
    "williamboman/mason.nvim",
    run = ":MasonUpdate", -- Update registry
  }

  use "williamboman/mason-lspconfig"
  use {
    "mfussenegger/nvim-lint",
    config = function()
      lint = require("lint")
      lint.linters_by_ft = {
        python = { 'ruff' }
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          lint.try_lint()
        end
      })
    end
  }
  use "fatih/vim-go"

  use {
    "nvim-telescope/telescope.nvim",
    config = function()
      tele = require("telescope")
      tele.load_extension("projects")
    end
  }
  use "folke/trouble.nvim"
  use {
    "akinsho/toggleterm.nvim",
    tag = '*',
    config = function()
      require("toggleterm").setup()
    end
  }

  use {

    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup()
    end

  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  -- Project management
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        patterns = { ".git", "package.json", "requiarements.txt" }
      }
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    tag = 'release',
    config = function()
      require('gitsigns').setup({
        signs = {
          add          = { text = '│' },
          change       = { text = '│' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signcolumn = true,
        numhl = true,
        linehl = true,

        current_line_blame = true, -- enable blame
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'right_align'
        }
      })
    end
  }

  use {
    'tanvirtin/vgit.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  use "sindrets/diffview.nvim"

  use {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = function ()
      require('neogit').setup()
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'lua', 'typescript', 'javascript', 'go', 'python', 'toml', 'json', 'sql', 'org' },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { 'org' }
        }
      })
    end
  }

  --- themes
  use 'folke/tokyonight.nvim'
  use 'nvim-tree/nvim-web-devicons'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup()
    end
  }
  use {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup()
    end
  }
  use {
    "xiyaowong/transparent.nvim",
    config = function()
      require("transparent").setup({
        'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
        'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
        'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
        'SignColumn', 'CursorLineNr', 'EndOfBuffer',
      })
    end
  }

  -- database explorer
  use {
    "tpope/vim-dadbod",
    opt = true,
    requires = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    config = function()
      require("oz.db").setup()
    end,
    cmd = { "DBUIToggle", "DBUI", "DBUIAddConnection", "DBUIFindBuffer", "DBUIRenameBuffer", "DBUILastQueryInfo" },
  }
  -- plugin development
  use {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup()
    end
  }

  -- org mode
  use {
    "nvim-orgmode/orgmode",
    config = function()
      require('orgmode').setup_ts_grammar()
      require("orgmode").setup({
        org_agenda_files = { "~/org/agenda" },
        org_default_notes_file = "~/org/notes.org",
      })
    end
  }
end)
