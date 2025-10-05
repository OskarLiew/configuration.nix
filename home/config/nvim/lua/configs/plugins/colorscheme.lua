return {
	{
		"sainnhe/everforest",
		lazy = false,
		priority = 1000,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.everforest_enable_italic = true
			vim.g.everforest_background = "medium"
			vim.g.everforest_transparent_background = 2
			vim.cmd.colorscheme("everforest")
		end,
	},
}
