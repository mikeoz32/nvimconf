return {
  'nvim-treesitter/nvim-treesitter',
  version = false,
  event = "VeryLazy",
  build = ":TSUpdate",
  opts = {
    ensure_installed = { 'lua', 'typescript', 'javascript', 'go', 'python', 'toml', 'json', 'sql', 'org' },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true
    }
  },
  config = function (_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end
}
