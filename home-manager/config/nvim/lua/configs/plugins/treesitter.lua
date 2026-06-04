local parsers = {
	"lua",
	"vim",
	"vimdoc",
	"query",
	"markdown",
	"markdown_inline",
	"python",
	"rust",
	"go",
	"javascript",
	"typescript",
	"tsx",
	"yaml",
	"json",
	"toml",
	"nix",
	"html",
	"css",
	"bash",
	"c_sharp",
	"sql",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function(_, opts)
			local ts = require("nvim-treesitter")

			ts.setup(opts)

			local installed = ts.get_installed()
			local missing = vim.tbl_filter(function(parser)
				return not vim.tbl_contains(installed, parser)
			end, parsers)

			if #missing > 0 then
				ts.install(missing)
			end
		end,
	},
}
