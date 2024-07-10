return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require('gitsigns').setup({
      signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signcolumn = true,
      numhl = true,
      linehl = true,

      current_line_blame = true,   -- enable blame
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'right_align'
      }
    })
  end
}
