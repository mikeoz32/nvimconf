--- Default values
---
---@class OzVimOptions
local defaults = {
  global = {
    backup = false,
    clipboard = "unnamedplus",               -- use system clipboard
    cmdheight = 2,                           -- height of nvim command status bar
    completeopt = { "menuone", "noselect" }, -- for cmp
    conceallevel = 0,                        -- make `` visible in .md files
    fileencoding = "utf-8",                  -- file encoding
    hlsearch = true,                         -- highlight search
    ignorecase = true,                       -- ignore case in searches
    mouse = "a",                             -- allow mouse to be used in nvim
    pumheight = 10,                          -- pop up menu height
    showmode = false,                        -- did not show mode name in status bar
    showtabline = 2,                         -- alwais show tabs in header to be able to see what tab is currntly active
    smartcase = true,                        -- smart case
    smartindent = true,                      -- smart indent
    splitbelow = true,                       -- always split windows vertically below
    splitright = true,                       -- always split windows horizontally right
    swapfile = true,                         -- create swap file
    timeoutlen = 1000,                       -- time to wait for a mapped sequence to complete in milliseconds
    termguicolors = true,                    -- add more colors to nvim
    undofile = true,                         -- enable persisten undo
    updatetime = 300,                        -- default is 4000ms, make faster completions
    writebackup = false,                     -- just do not write any backups
    expandtab = true,
    shiftwidth = 2,
    tabstop = 2,
    cursorline = true,      -- highlight current line
    number = true,          -- show line number
    relativenumber = false, -- never show relative line numbers only absolute
    numberwidth = 2,        -- set width of column that sshows line numbers to 2 instead of default 4
    signcolumn = "yes",     -- show sign column
    wrap = false,           -- never wrap lines
    scrolloff = 8,
    sidescrolloff = 8
  },
  keymap = {
    leader = " "
  },
  lang = {
    python = {
      enabled = true
    }
  }
}

local M = {}

M.options = {}

function M.setup()
  M.options = defaults
  for _, v in ipairs(M.get_config_dirs()) do
    M.options = vim.tbl_deep_extend("force", M.options, OzVim.toml.load(v))
  end

  for k, v in pairs(M.options.global) do
    vim.opt[k] = v
  end

  local leader = M.options.keymap.leader or " "


  local opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap("", "<Space>", "<Nop>", opts)
  vim.g.mapleader = leader
  vim.g.maplocalleader = leader
end

function M.get_config_dirs()
  local std_config = vim.fn.stdpath('config') .. "/ozvim.toml"
  local cwd = vim.uv.cwd() .. "/.ozvim/config.toml"
  return { std_config, cwd }
end

function M.lang_enabled(lang)
  local opts = vim.tbl_get(M.options.lang, lang)
  if opts.enabled then
    return true
  end
  vim.notify("Lang not enabled" .. lang)
end

return M
