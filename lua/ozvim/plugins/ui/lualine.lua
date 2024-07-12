local hatch = require("ozvim.py.hatch")
return {
  "nvim-lualine/lualine.nvim",

  dependencies = { 'nvim-tree/nvim-web-devicons', "folke/noice.nvim" },
  opts = function()
    return {
      options = {
        theme = "auto",
        globalstatus = true
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { "buffers" },
        lualine_x = { hatch.get_active_env() }
      }
    }
  end,
  -- config = function()
  --   require('lualine').setup({
  --     options = {
  --       icons_enabled = true,
  --       component_separators = "|",
  --       section_separators = ""
  --     },
  --     sections = {
  --       lualine_x = {
  --         {
  --           require("noice").api.statusline.mode.get,
  --           cond = require("noice").api.statusline.mode.has,
  --           color = { fg = "#ff9e64" },
  --         },
  --         {
  --           require("noice").api.status.command.get,
  --           cond = require("noice").api.status.command.has,
  --           color = { fg = "#ff9e64" },
  --         },
  --       },
  --       lualine_a = {
  --         {
  --           'buffers',
  --         }
  --       },
  --       lualine_b = {
  --         'branch',
  --         'diff'
  --       }
  --     }
  --
  --   })
  -- end
}
