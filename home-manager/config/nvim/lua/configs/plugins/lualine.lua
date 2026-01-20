local path = function()
	local relative = vim.fn.fnamemodify(vim.fn.expand("%:h"), ":~:.")
	return relative
end
return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "/", right = "/" },
					section_separators = { left = "\u{e0bc}", right = "\u{e0ba}" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { path, "filename" },
					lualine_x = { "lsp_status" },
					lualine_y = { "filetype" },
					lualine_z = { "location", "progress" },
				},
				inactive_sections = {
					lualine_c = { "filename" },
				},
				extensions = {},
			})
		end,
	},
}
