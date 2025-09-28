return {
	{
		"mbbill/undotree",
		init = function()
			vim.keymap.set("n", "<leader>u", "<cmd> UndotreeToggle <CR>", { desc = "Undotree" })
		end,
		cmd = "UndotreeToggle",
	},
}
