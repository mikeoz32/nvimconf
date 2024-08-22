-- Windows

OzVim.key_map({ "n" }, "<leader>wh", "<C-w>h", { desc = "Go to Left Window" })
OzVim.key_map({ "n" }, "<leader>wl", "<C-w>l", { desc = "Go to Right Window" })
OzVim.key_map({ "n" }, "<leader>wj", "<C-w>j", { desc = "Go to Lower Window" })
OzVim.key_map({ "n" }, "<leader>wk", "<C-w>k", { desc = "Go to Upper Window" })

OzVim.key_map({ "n" }, "<leader>wc", "<cmd>close<cr>", { desc = "Window Close" })
OzVim.key_map({ "n" }, "<leader>wq", "<cmd>q<cr>", { desc = "Window Quit" })
OzVim.key_map({ "n" }, "<leader>ws", "<cmd>sp<cr>", { desc = "Window Split" })


OzVim.key_map({ "n" }, "<leader>wwh", "<cmd>vertical resize +2<cr>", { desc = "Window Resize Left" })
OzVim.key_map({ "n" }, "<leader>wwl", "<cmd>vertical resize -2<cr>", { desc = "Window Resize Right" })
OzVim.key_map({ "n" }, "<leader>wwj", "<cmd>resize +2<cr>", { desc = "Window Resize Down" })
OzVim.key_map({ "n" }, "<leader>wwk", "<cmd>resize -2<cr>", { desc = "Window Resize Up" })


-- Buffers
OzVim.key_map({ "n" }, "<leader>bn", "<cmd>bnext<cr>")
OzVim.key_map({ "n" }, "<leader>bp", "<cmd>bprevious<cr>")
OzVim.key_map({ "n" }, "<leader>bd", OzVim.ui.bufremove, { desc = "Delete Buffer" })
OzVim.key_map({ "n" }, "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })
OzVim.key_map({ "n" }, "<leader>bs", "<cmd>Telescope buffers<cr>", { desc = "Search buffer" })
OzVim.key_map({ "n" }, "<leader>bod", "<cmd>BufferLineCloseOthers<cr>", { desc = "Buffer Others Delete" })

-- Clear search with <esc>
OzVim.key_map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Files
OzVim.key_map({ "n" }, "<leader>fw", ":w<cr>", { desc = "File Write" })
OzVim.key_map({ "n" }, "<leader>ff", "<cmd>Telescope live_grep<cr>", { desc = "Find in Files" })

-- Directory
OzVim.key_map({ "n" }, "<leader>db", "<cmd>NvimTreeToggle<cr>", { desc = "Directory Browse" })
OzVim.key_map({ "n" }, "<leader>ds", "<cmd>Telescope find_files<cr>", { desc = "Directory search" })

-- Visual mode keymaps "v"
-- Stay in indent mode
OzVim.key_map("v", "<", "<gv")
OzVim.key_map("v", ">", ">gv")


-- Go to
OzVim.key_map({ "n" }, "gd", vim.lsp.buf.definition, { desc = "Go To Definition" })
OzVim.key_map({ "n" }, "gD", vim.lsp.buf.declaration, { desc = "Go To Declaration" })
OzVim.key_map({ "n" }, "gi", vim.lsp.buf.implementation, { desc = "Go To Implementation" })

-- Zen mode
OzVim.key_map({ "n" }, "<leader>zz", "<cmd>ZenMode<cr>", { desc = "Zen Mode" })

-- Git
OzVim.key_map({ "n" }, "<leader>gt", "<cmd>Neogit kind=split<cr>", { desc = "Git Toggle Neogit" })

-- Code inspection
OzVim.key_map({ "n" }, "<leader>cd", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics" })
OzVim.key_map({ "n" }, "<leader>cD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Diagnostics Buffer" })
OzVim.key_map({ "n" }, "<leader>cs", "<cmd>Outline<cr>", { desc = "Symbols" })
OzVim.key_map({ "n" }, "<leader>cf", vim.lsp.buf.format, { desc = "Format buffer" })
OzVim.key_map({ "n" }, "<leader>cc", vim.lsp.buf.code_action, { desc = "Code Action" })


-- Run Tests
OzVim.key_map({ "n" }, "<leader>rtf", function() require("neotest").run.run(vim.fn.expand("%")) end,
  { desc = "Run Test in File" })

OzVim.key_map({ "n" }, "<leader>rtt", function() require("neotest").run.run(vim.uv.cwd()) end,
  { desc = "Run All Tests " })
