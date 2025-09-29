return {
	{
		"crawlerr",
		dir = vim.fn.stdpath("config") .. "/lua/plugins/crawlerr",
		lazy = false,
		cond = function() -- Only load when there is a network/ directory in cwd
			local uv = vim.uv or vim.loop
			local path = vim.fn.getcwd() .. "/network"
			local st = uv.fs_stat(path)
			return st and st.type == "directory"
		end,
		config = function()
			local crawlerr = require("plugins.crawlerr")
			crawlerr.setup()

			-- Mappings
			vim.keymap.set("n", "<leader>jn", crawlerr.jump_to_node, { desc = "RR jump to node" })
			vim.keymap.set("n", "<leader>je", function()
				crawlerr.jump_to_texts("en")
			end, { desc = "Go to node text en" })
			vim.keymap.set("n", "<leader>js", function()
				crawlerr.jump_to_texts("sv")
			end, { desc = "Go to node text sv" })
			vim.keymap.set("n", "<leader>fn", crawlerr.quick_scope, { desc = "RR - QuickScope" })
		end,
	},
}
