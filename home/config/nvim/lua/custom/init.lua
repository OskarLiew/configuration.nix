local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
    pattern = "*",
    command = "tabdo wincmd =",
})

local opt = vim.opt

opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.modeline = false -- Inline vim settings
opt.synmaxcol = 256 -- Limit syntax highlighting for long lines

-- Setup clipboard tool, saved .5s on startup
vim.g.clipboard = nil
opt.smartindent = true

opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("XDG_CACHE_HOME") .. "/vim/undodir"
opt.undofile = true

opt.incsearch = true

opt.scrolloff = 8
opt.signcolumn = "yes"

opt.colorcolumn = "88"

-- Snippets
vim.g.vscode_snippets_path = os.getenv("XDG_CONFIG_HOME") .. "/snippets"

opt.clipboard = nil

-- Autocmds
require("custom.configs.autocmds")
