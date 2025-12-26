return {
  "nvim-lualine/lualine.nvim",

  dependencies = { 'nvim-tree/nvim-web-devicons', "folke/noice.nvim" },
  config = function()
    require('lualine').setup({
      options = {
        theme = "tokyonight",
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true, -- один statusline на всі вікна
        disabled_filetypes = { 'NvimTree', 'neo-tree', 'alpha' },
      },
      sections = {
        lualine_x = {
          {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
            color = { fg = "#ff9e64" },
          },
          {
            require("noice").api.status.command.get,
            cond = require("noice").api.status.command.has,
            color = { fg = "#ff9e64" },
          },
          {
            function()
              local msg = 'No LSP'
              local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
              local clients = vim.lsp.get_clients()
              if next(clients) == nil then return msg end
              for _, client in ipairs(clients) do
                if client.config.filetypes and vim.tbl_contains(client.config.filetypes, buf_ft) then
                  return client.name
                end
              end
              return msg
            end,
            icon = ' ',
          }
        },
        -- lualine_a = {
        --   {
        --     'buffers',
        --   }
        -- },
        lualine_b = {
          'branch',
          'diff'
        },
        lualine_c = {
          {
            'filename',
            path = 1, -- 0 = just filename, 1 = relative, 2 = absolute
            symbols = {
              modified = '●', -- файл змінено
              readonly = '🔒',
              unnamed = '[No Name]',
              newfile = '[New]',
            }
          }
        }
      }

    })

  end
}
