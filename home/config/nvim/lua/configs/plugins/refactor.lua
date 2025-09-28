return {
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		event = {
			"BufEnter", -- TODO: Better load criterion
		},
		init = function()
			vim.keymap.set("n", "<leader>rr", "<leader>ra", { desc = "Rename" })
			vim.keymap.set("v", "<leader>re", "<cmd> Refactor extract <CR>", { desc = "Extract method" })
			vim.keymap.set(
				"v",
				"<leader>rf",
				"<cmd> Refactor extract_to_file <CR>",
				{ desc = "Rxtract method to file" }
			)
			vim.keymap.set("v", "<leader>rv", "<cmd> Refactor extract_var <CR>", { desc = "Extract variable" })
			vim.keymap.set("v", "<leader>ri", "<cmd> Refactor inline_var <CR>", { desc = "Inline variable" })
			vim.keymap.set("v", "<leader>rb", "<cmd> Refactor extract_block <CR>", { desc = "Extract block" })
			vim.keymap.set(
				"v",
				"<leader>rB",
				"<cmd> Refactor extract_block_to_file <CR>",
				{ desc = "Extract block to file" }
			)
		end,
		config = function()
			require("refactoring").setup()
		end,
	},
}
