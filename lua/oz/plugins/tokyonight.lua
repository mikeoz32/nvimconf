return {
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
}
