local opt = vim.opt

-- Appearance & UI
opt.termguicolors = true
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.numberwidth = 4
opt.signcolumn = "yes"
opt.colorcolumn = "100"
opt.wrap = false
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.showmode = false
opt.showtabline = 2
opt.pumheight = 10
opt.cmdheight = 1
opt.conceallevel = 0

-- Indentation
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

-- Search & Splits
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.splitbelow = true
opt.splitright = true

-- Files, Backups & Undo
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.fileencoding = "utf-8"
opt.updatetime = 300
opt.timeoutlen = 1000
opt.clipboard = "unnamedplus"
opt.completeopt = { "menuone", "noselect" }

-- Ripgrep integration
if vim.fn.executable("rg") == 1 then
    opt.grepprg = "rg --vimgrep --no-heading --smart-case"
    opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end

-- Diagnostic signs
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = "󰌵",
        },
    },
})
