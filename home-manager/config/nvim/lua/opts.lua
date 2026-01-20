local opt = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = "\\"

-------------------------------------- options ------------------------------------------
opt.laststatus = 3 -- global statusline
opt.showmode = false

opt.cursorline = true
opt.wrap = false

opt.modeline = false -- Inline vim settings
opt.synmaxcol = 256 -- Limit syntax highlighting for long lines

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false
opt.relativenumber = true

-- Indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- disable nvim intro
opt.shortmess:append("sI")

opt.scrolloff = 8
opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400

opt.undofile = true
opt.undodir = os.getenv("XDG_CACHE_HOME") .. "/vim/undodir"

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

-- Setup clipboard tool, saved .5s on startup
g.clipboard = nil
opt.clipboard = nil

opt.swapfile = false
opt.backup = false

opt.incsearch = true

-- Snippets
g.vscode_snippets_path = os.getenv("XDG_CONFIG_HOME") .. "/snippets"

-- Define diagnostic signs
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
})
