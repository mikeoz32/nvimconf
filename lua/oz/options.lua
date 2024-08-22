vim.opt.backup = false
vim.opt.clipboard = "unnamedplus" -- use system clipboard
vim.opt.cmdheight = 2 -- height of nvim command status bar 
vim.opt.completeopt = {"menuone", "noselect"} -- for cmp
vim.opt.conceallevel = 0 -- make `` visible in .md files
vim.opt.fileencoding = "utf-8" -- file encoding
vim.opt.hlsearch = true -- highlight search
vim.opt.ignorecase = true -- ignore case in searches
vim.opt.mouse ="a" -- allow mouse to be used in nvim
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.showmode = false -- did not show mode name in status bar
vim.opt.showtabline = 2 -- alwais show tabs in header to be able to see what tab is currntly active
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- smart indent
vim.opt.splitbelow = true -- always split windows vertically below
vim.opt.splitright = true -- always split windows horizontally right
vim.opt.swapfile = true -- create swap file
vim.opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete in milliseconds
vim.opt.termguicolors = true -- add more colors to nvim
vim.opt.undofile = true -- enable persisten undo
vim.opt.updatetime = 300 -- default is 4000ms, make faster completions
vim.opt.writebackup = false -- just do not write any backups
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.cursorline = true -- highlight current line
vim.opt.number = true -- show line number
vim.opt.relativenumber = false -- never show relative line numbers only absolute
vim.opt.numberwidth = 2 -- set width of column that sshows line numbers to 2 instead of default 4
vim.opt.signcolumn = "yes" -- show sign column
vim.opt.wrap = fasle -- never wrap lines
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.shortmess:append "c"

vim.g.transparent_enabled = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]

-- vim.cmd [[colorscheme tokyonight]]
vim.g.python3_host_prog = 'py'

if vim.g.neovide then
  vim.g.neovide_scale_factor = 0.5
end
