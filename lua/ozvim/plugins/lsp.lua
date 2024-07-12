return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
    lazy = false
  },
  {
    "williamboman/mason-lspconfig",
    dependencies = {
      "mason.nvim"
    },
    opts = {
      ensure_installed = { 'pyright', 'ruff_lsp' }
    }
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    event = "VeryLazy",
    config = function(_, opts)
      local lsp = require("lspconfig")
      local cmp = require("cmp_nvim_lsp")

      local servers = opts.servers
      local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(),
        cmp.default_capabilities())

      for server, server_opts in pairs(servers) do
        local o = vim.tbl_deep_extend("force", { capabilities = vim.deepcopy(capabilities) }, server_opts or {})
        if server_opts.enabled ~= false then
          lsp[server].setup(o)
        end
      end
    end
  }
}
