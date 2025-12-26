return {
  'nvim-treesitter/nvim-treesitter',
  version = false,
  event = "VeryLazy",
  build = ":TSUpdate",
  opts = {
    ensure_installed = { 'lua', 'typescript', 'javascript', 'go', 'python', 'toml', 'json', 'sql', 'org', "elixir", "eex", "heex" },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true
    }
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
    vim.api.nvim_create_autocmd("User", {
      pattern = "TSUpdate",
      callback = function()
        require("nvim-treesitter.parsers").crystal = {
          install_info = {
            url = 'https://github.com/crystal-lang-tools/tree-sitter-crystal',
            generate = false,
            generate_from_json = false,
            queries = 'queries/nvim'
          },
        }
        require("nvim-treesitter.parsers").org = {
          install_info = {
            url = 'https://github.com/milisims/tree-sitter-org',
            revision = 'main',
            files = { 'src/parser.c', 'src/scanner.c' },
          },
          filetype = 'org',
        }
      end
    })

    vim.treesitter.language.register('crystal', { 'cr' })
  end
}
