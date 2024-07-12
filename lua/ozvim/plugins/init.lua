return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent"
      }
    },
    init = function()
      vim.cmd [[colorscheme tokyonight]]
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    event = "VeryLazy",
    build = ":TSUpdate",
    lazy = vim.fn.argc(-1) == 0,
    -- opts_extend = { "ensure_installed", "highlight" },
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    opts = {
      ensure_installed = { 'python' },
      indent = {
        enable = true
      }
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end
  },
  {
    import = "ozvim.plugins.ui"
  },
  {
    import = "ozvim.plugins.lang.python",
    enabled = function()
      return OzVim.options.lang_enabled("python")
    end
  },
}
