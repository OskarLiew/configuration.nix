return {
	"GustavEikaas/easy-dotnet.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },

	ft = { "cs" },

	config = function()
		require("easy-dotnet").setup({ lsp = {
			set_fold_expr = false,
		} })
	end,
}
