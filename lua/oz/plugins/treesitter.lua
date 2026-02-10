return {
  'nvim-treesitter/nvim-treesitter',
  version = false,
  lazy = false,
  build = ":TSUpdate",
  config = function(_, opts)
    vim.filetype.add({
      extension = {
        cr = 'crystal',
      },
    })
    vim.treesitter.language.register('crystal', { 'cr' })
    require("nvim-treesitter.configs").setup(
      {
        ensure_installed = { 'lua', 'typescript', 'javascript', 'go', 'python', 'toml', 'json', 'sql', "elixir", "eex", "heex" },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true
        }
      })
    vim.api.nvim_create_autocmd("User", {
      pattern = "TSUpdate",
      callback = function()
        require("nvim-treesitter.parsers").crystal = {
          install_info = {
            url = 'https://github.com/crystal-lang-tools/tree-sitter-crystal',
            branch = 'main',
            generate = false,
            generate_from_json = false,
            queries = 'queries/nvim'
          },
        }
        require("nvim-treesitter").install('crystal')
      end
    })
  end
}
