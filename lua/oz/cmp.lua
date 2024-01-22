--- nvim cmp configuration

local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
  print "Failed to load nvim-cmp, please check installation"
  return
end

local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end
  },
  sources = {
    {name="nvim_lsp"},
    {name="buffer"},
    {name="path"},
    {name="orgmode"},
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
    ['<Tab>'] = cmp.mapping(function(falback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        falback()
      end
    end
  )})

})
