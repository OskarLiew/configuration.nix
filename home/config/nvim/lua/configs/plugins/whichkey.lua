return {
	{
		"folke/which-key.nvim",
		keys = { "<leader>", "<c-r>", '"', "'", "`", "c", "v", "g" },
		init = function()
			vim.keymap.set("n", "<leader>hW", function()
				vim.cmd("WhichKey")
			end, { desc = "Which-key all keymaps" })

			vim.keymap.set("n", "<leader>hw", function()
				local input = vim.fn.input("WhichKey: ")
				vim.cmd("WhichKey " .. input)
			end, { desc = "Which-key query lookup" })
		end,
		cmd = "WhichKey",
		config = function()
			require("which-key").setup({
				spec = {
					{ "<leader>c", group = "code" },
					{ "<leader>d", group = "debug" },
					{ "<leader>f", group = "find" },
					{ "<leader>g", group = "git" },
					{ "<leader>h", group = "help" },
					{ "<leader>r", group = "refactor" },
					{ "<leader>s", group = "settings" },
					{ "<leader>w", group = "workspace" },
					{ "<leader>x", group = "error" },
				},
			})
		end,
	},
}
