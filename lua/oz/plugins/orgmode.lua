return
{
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      require('orgmode').setup({
        org_agenda_files = { '~/orgfiles/**/*', vim.uv.cwd() .. '/docs/**/*' },
        org_default_notes_file = '~/orgfiles/refile.org',
        org_startup_indented = true,
        org_adapt_indentation = true,
        org_indent_mode_turns_off_org_adapt_indentation = false,
        org_todo_keywords = {'TODO', 'WORKING', 'ON_HOLD','|', 'DONE'}
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
