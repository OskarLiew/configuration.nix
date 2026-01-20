local function using_nix()
	return vim.env.IN_NIX_SHELL or vim.env.NIX_PROFILES or vim.env.NIX_PATH
end

return {
	{
		"mason-org/mason.nvim",
		opts = {},
		enabled = function()
			return not using_nix()
		end,
	},
}
