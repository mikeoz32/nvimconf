return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  -- keys = {
  --   { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
  --   { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
  --   { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
  --   { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
  --   { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
  --   { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
  --   { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
  --   { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
  --   { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
  --   { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
  --   { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
  -- },
  opts = {
    options = {
      -- stylua: ignore
      close_command = function(n) OzVim.ui.bufremove(n) end,
      -- stylua: ignore
      right_mouse_command = function(n) OzVim.ui.bufremove(n) end,
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      diagnostics_indicator = function(_, _, diag)
        local icons = OzVim.icons.diagnostics
        local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
        return vim.trim(ret)
      end,
      offsets = {
        {
          filetype = "NvimTree",
          text = "Explorer",
          highlight = "Directory",
          text_align = "left",
        },
      },
      get_element_icon = function(opts)
        return OzVim.icons.ft[opts.filetype]
      end,
    },
  },
}
