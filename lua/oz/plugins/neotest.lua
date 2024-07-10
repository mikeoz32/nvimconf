return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-neotest/neotest-python"
  },

  config = function()
    require("neotest").setup({
      adapters = require("neotest-python")({})
    })
  end
}
