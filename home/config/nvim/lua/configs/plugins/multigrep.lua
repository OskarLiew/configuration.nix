return {
	{
		"multigrep",
		dir = vim.fn.stdpath("config") .. "/lua/plugins/multigrep",
		keys = "<leader>fG",
		config = function()
			local mg = require("plugins.multigrep")
			mg.setup()
			-- Mappings
			vim.keymap.set("n", "<leader>fG", mg.live_multigrep)
		end,
	},
}
