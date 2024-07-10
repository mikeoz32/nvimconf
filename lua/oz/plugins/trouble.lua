return {
  "folke/trouble.nvim",

  config = function()
    require("project_nvim").setup {
      patterns = { ".git", "package.json", "requiarements.txt" }
    }
  end
}
