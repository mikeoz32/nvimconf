return
{
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      -- local cwd = vim.uv.cwd() .. '/docs/**/*'
      require('orgmode').setup({
        org_agenda_files = { '~/orgfiles/**/*' },
        org_default_notes_file = '~/orgfiles/refile.org',
        org_startup_indented = true,
        org_adapt_indentation = true,
        org_indent_mode_turns_off_org_adapt_indentation = false
      })

      -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
      -- add ~org~ to ignore_install
      -- require('nvim-treesitter.configs').setup({
      --   ensure_installed = 'all',
      --   ignore_install = { 'org' },
      -- })
    end,
  },
  {
    "akinsho/org-bullets.nvim",
    config = function()
      require('org-bullets').setup()
    end
  }
}
