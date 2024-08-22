return {
  {
    "hrsh7th/vim-vsnip"
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      "hrsh7th/cmp-vsnip",
    },
    opts = function()
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()

      return {
        completion = {
          completeot = "menu,menuone,noinsert"
        },
        sorting = defaults.sorting,
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
          { name = "cmdline" },
          { name = "vsnip" }
        }),

        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ['<CR>'] = cmp.mapping.confirm({
            select = true }),
          ['<Tab>'] = cmp.mapping(function(falback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              falback()
            end
          end
          )
        })
      }
    end
  }
}
