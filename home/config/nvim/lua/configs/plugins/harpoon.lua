return {
	{
		"ThePrimeagen/harpoon",
		init = function()
			vim.keymap.set("n", "<leader>a", function()
				require("harpoon.mark").add_file()
			end, { desc = "add file" })
			vim.keymap.set("n", "<C-e>", function()
				require("harpoon.ui").toggle_quick_menu()
			end, { desc = "quick menu" })
			vim.keymap.set("n", "<leader>1", function()
				require("harpoon.ui").nav_file(1)
			end, { desc = "go to file 1" })
			vim.keymap.set("n", "<leader>2", function()
				require("harpoon.ui").nav_file(2)
			end, { desc = "go to file 2" })
			vim.keymap.set("n", "<leader>3", function()
				require("harpoon.ui").nav_file(3)
			end, { desc = "go to file 3" })
			vim.keymap.set("n", "<leader>4", function()
				require("harpoon.ui").nav_file(4)
			end, { desc = "go to file 4" })
		end,
		event = { "BufEnter" },
	},
}
