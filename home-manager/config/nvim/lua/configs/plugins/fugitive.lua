return {
	{
		"tpope/vim-fugitive",
		init = function()
			vim.keymap.set("n", "<leader>gg", "<cmd> Git <CR>", { desc = "Fugitive" })
			vim.keymap.set("n", "<leader>gd", "<cmd> Gdiffsplit <CR>", { desc = "Diffsplit" })
			vim.keymap.set("n", "<leader>gB", "<cmd> Git blame <CR>", { desc = "Blame file" })
			vim.keymap.set("n", "<leader>gf", "<cmd> Git log -- %  <CR>", { desc = "File history" })
			vim.keymap.set(
				"n",
				"<leader>gl",
				"<cmd> execute 'Git log --format=reference -L ' . line('.') . ',' . line('.') . ':%' <CR>",
				{ desc = "Line history" }
			)
		end,
		event = "BufRead",
		cmd = { "Git", "G" },
	},
}
