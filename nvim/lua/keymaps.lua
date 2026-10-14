local set = vim.keymap.set
local silent = { silent = true }

-- Disable space default behavior
set({ "n", "v" }, "<Space>", "<Nop>", silent)

-- Window navigation
set("n", "<C-h>", "<C-w>h", silent)
set("n", "<C-j>", "<C-w>j", silent)
set("n", "<C-k>", "<C-w>k", silent)
set("n", "<C-l>", "<C-w>l", silent)
set("n", "<leader>wh", "<C-w>h", { desc = "Window left", silent = true })
set("n", "<leader>wj", "<C-w>j", { desc = "Window down", silent = true })
set("n", "<leader>wk", "<C-w>k", { desc = "Window up", silent = true })
set("n", "<leader>wl", "<C-w>l", { desc = "Window right", silent = true })
set("n", "<leader>wc", "<C-w>c", { desc = "Close window", silent = true })
set("n", "<leader>wv", "<C-w>v", { desc = "Vertical split", silent = true })
set("n", "<leader>ws", "<C-w>s", { desc = "Horizontal split", silent = true })

-- Window resizing
set("n", "<C-Up>", "<cmd>resize -2<cr>", silent)
set("n", "<C-Down>", "<cmd>resize +2<cr>", silent)
set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", silent)
set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", silent)

-- Buffer navigation
set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer", silent = true })
set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer", silent = true })
set("n", "<S-m>", "<cmd>bdelete<cr>", { desc = "Delete buffer", silent = true })
set("n", "<S-j>", "<Nop>", silent)

-- Move text up and down
set("n", "<A-j>", "<cmd>m .+1<cr>==", silent)
set("n", "<A-k>", "<cmd>m .-2<cr>==", silent)
set("v", "<A-j>", ":m '>+1<cr>gv=gv", silent)
set("v", "<A-k>", ":m '<-2<cr>gv=gv", silent)

-- Stay in indent mode
set("v", "<", "<gv^", silent)
set("v", ">", ">gv^", silent)

-- Paste without overwriting default register
set("v", "p", '"_dP', silent)

-- Actions
set("n", "U", "<cmd>redo<cr>", silent)
set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all", silent = true })
set("n", "<leader>t", "<cmd>set invexpandtab<cr>", { desc = "Toggle expandtab", silent = true })

-- LSP control
set("n", "<leader>lf", "<cmd>LspStop<cr>", { desc = "LSP Stop", silent = true })
set("n", "<leader>ln", "<cmd>LspStart<cr>", { desc = "LSP Start", silent = true })
