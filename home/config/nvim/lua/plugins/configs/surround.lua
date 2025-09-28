return {
	{
		"tpope/vim-surround",
		dependencies = {
			{
				"tpope/vim-repeat",
				event = {
					"BufEnter",
				},
				config = function()
					vim.cmd([[silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)]])
				end,
			},
		},
		event = {
			"BufEnter",
		},
	},
}
