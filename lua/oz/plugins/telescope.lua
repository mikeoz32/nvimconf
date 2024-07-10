return {
  "nvim-telescope/telescope.nvim",
  config = function()
      local tele = require("telescope")
      tele.load_extension("projects")
  end
}
