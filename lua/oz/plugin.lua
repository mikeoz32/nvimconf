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
      return require("packer.util").float {border = rounded}
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
  use "fatih/vim-go"

  use {
    "tanvirtin/vgit.nvim",
    config = function ()
      require("vgit").setup({
        live_blame = {
          enabled = true,
          format = function (blame, git_config)
            return string.format('%s - %s', blame.author, blame.commit_message)
            
          end
        }
      })
    end
  }

  use {
    "nvim-telescope/telescope.nvim",
    config = function()
      tele = require("telescope")
      tele.load_extension("projects")
    end
  }
  -- Project management
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        patterns = {".git","package.json", "requiarements.txt"}
      }
    end
  }

  --- themes
  use 'folke/tokyonight.nvim'
  use 'nvim-tree/nvim-web-devicons'

  use {
    'nvim-lualine/lualine.nvim',
    requires = {'nvim-tree/nvim-web-devicons'},
    config = function()
      require('lualine').setup()
    end
  }
  use {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
end)
