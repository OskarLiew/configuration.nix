-- LSPs to enable
local lsps = {
	"lua_ls",
	"stylua",
	"pyright",
	"ruff",
	"html",
	"cssls",
	"ts_ls",
	"clangd",
	"nil_ls", -- General nix language
	"nixd", -- nixpkgs
	"gopls",
	"bashls",
	"docker_compose_language_service",
	"dockerls",
	"taplo",
	"yamlls",
}

-- Option overrides
local lsp_opts = {}

return {
	{
		"https://github.com/neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		init = function()
			vim.keymap.set("n", "gD", function()
				vim.lsp.buf.declaration()
			end, { desc = "LSP declaration" })
			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end, { desc = "LSP definition" })
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover({ border = "rounded" })
			end, { desc = "LSP hover" })
			vim.keymap.set("n", "gi", function()
				vim.lsp.buf.implementation()
			end, { desc = "LSP implementation" })
			vim.keymap.set("n", "<leader>ls", function()
				vim.lsp.buf.signature_help()
			end, { desc = "LSP signature help" })
			vim.keymap.set("n", "<leader>D", function()
				vim.lsp.buf.type_definition()
			end, { desc = "LSP definition type" })
			vim.keymap.set("n", "<leader>ra", function()
				vim.lsp.buf.rename()
			end, { desc = "LSP rename" })
			vim.keymap.set("n", "<leader>ca", function()
				vim.lsp.buf.code_action()
			end, { desc = "LSP code action" })
			vim.keymap.set("n", "gr", function()
				vim.lsp.buf.references()
			end, { desc = "LSP references" })
			vim.keymap.set("n", "<leader>X", function()
				vim.diagnostic.open_float({ border = "rounded" })
			end, { desc = "Diagnostic hover" })
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = 1, float = true })
			end, { desc = "Previous diagnostic" })
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.jump({ count = -1, float = true })
			end, { desc = "Next diagnostic" })
			vim.keymap.set("n", "<leader>xq", function()
				vim.diagnostic.setloclist()
			end, { desc = "Setloclist with diagnostics" })
			vim.keymap.set("n", "<leader>wa", function()
				vim.lsp.buf.add_workspace_folder()
			end, { desc = "Add workspace folder" })
			vim.keymap.set("n", "<leader>wr", function()
				vim.lsp.buf.remove_workspace_folder()
			end, { desc = "Remove workspace folder" })
			vim.keymap.set("n", "<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, { desc = "List workspace folders" })
		end,
		config = function()
			for lsp, opts in pairs(lsp_opts) do
				vim.lsp.config(lsp, opts)
			end
			vim.lsp.enable(lsps)
		end,
	},
}
