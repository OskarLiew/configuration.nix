return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				python = { "ruff_format", "ruff_organize_imports" },
				lua = { "stylua" },
				markdown = { "prettier" },
				css = { "prettier" },
				nix = { "nixfmt" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
	},
}
