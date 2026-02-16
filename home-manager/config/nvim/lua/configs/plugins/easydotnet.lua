return {
	"GustavEikaas/easy-dotnet.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },

	ft = { "cs" },

	config = function()
		require("easy-dotnet").setup()
	end,
}
