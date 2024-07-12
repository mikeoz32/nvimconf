return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    signs_staged = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
    },
    signcolumn = true,
    numhl = true,
    linehl = true,

    current_line_blame = true, -- enable blame
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'right_align'
    }
  },
}
