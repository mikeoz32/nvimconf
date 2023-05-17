local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

local wk = require("which-key")

-- Set leader key to spacebar 
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

wk.register({
  w = {
    name = "Window",
    h = {"<C-w>h", "Go to window left"},
    j = {"<C-w>j", "Go to windows down"},
    k = {"<C-w>k", "Go to window up"},
    s = {"<cmd>sp<cr>", "Split window"},
    c = {"<cmd>close<cr>", "Close window"},
    q = {"<cmd>q<cr>", "Quit Window"}
  }, 
},{prefix="<leader>"})


wk.register({
  t = {
    name = "Tabs",
    l = {"<cmd>tabnext<cr>", "Tab right"},
    h = {"<cmd>tabprev<cr>", "Tab left"},
    n = {"<cmd>tabnew<cr>", "New tab"},
  },
},{prefix="<leader>"})

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<cr>", opts)
keymap("n", "<C-Down>", ":resize +2<cr>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<cr>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<cr>", opts)

-- Buffers
-- Buffer next
keymap("n", "<leader>bn", ":bnext<cr>", opts)
-- Buffer previous
keymap("n", "<leader>bp", ":bprevious<cr>", opts)

-- Files 
-- Write file
keymap("n", "<leader>fw", ":w<cr>", opts)




-- Visual mode keymaps "v"
-- Stay in indent mode
keymap("v","<","<gv", opts)
keymap("v",">",">gv", opts)


-- Directory Browse
local tscope = require("telescope.builtin")
local telescope = require("oz.telescope")
vim.keymap.set("n", "<leader>db", vim.cmd.Ex)
-- keymap("n", "<leader>db", ":NvimTreeToggle<cr>", opts)
-- keymap("n", "<leader>df", ":NvimTreeFindFileToggle<cr>", opts)
vim.keymap.set("n", "<leader>ds", tscope.find_files)
vim.keymap.set("n", "<leader>cs", telescope.search_in_config_dir )

wk.register({
  p = {
    name = "Project",
    p = {telescope.select_project, "Show recent projects"},
  }, 
},{prefix="<leader>"})
-- LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition)

local zen = require("zen-mode")
vim.keymap.set("n", "<leader>zz", zen.toggle)
-- Git 
-- local term = require("oz.term")
-- Git Toggle
--

-- Project
-- vim.keymap.set("n", "<leader>pp", function()
  -- t = require("telescope")
  -- t.extensions.projects.projects({})
-- end)

local terminals = require("oz.terminals")
vim.keymap.set("n", "<leader>gt", terminals.lazygit_toggle)
