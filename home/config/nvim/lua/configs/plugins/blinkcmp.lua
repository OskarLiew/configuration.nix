local function lspkind_comparator(conf)
	local function get_kind(kindId)
		for key, value in pairs(vim.lsp.protocol.CompletionItemKind) do
			if value == kindId then
				return key
			end
		end
	end
	return function(entry1, entry2)
		local kind1 = get_kind(entry1.kind)
		local kind2 = get_kind(entry2.kind)

		local priority1 = conf.kind_priority[kind1] or 0
		local priority2 = conf.kind_priority[kind2] or 0
		if priority1 == priority2 then
			return nil
		end
		return priority2 < priority1
	end
end
local kind_comparator = lspkind_comparator({
	kind_priority = {
		Parameter = 14,
		Variable = 12,
		Field = 12,
		Property = 12,
		EnumMember = 12,
		Constant = 11,
		Function = 10,
		Method = 10,
		Event = 10,
		Struct = 9,
		Class = 9,
		Enum = 9,
		Module = 8,
		Operator = 7,
		Reference = 7,
		File = 6,
		Folder = 6,
		Color = 5,
		Constructor = 1,
		Interface = 1,
		Snippet = 1,
		Text = 1,
		TypeParameter = 1,
		Unit = 1,
		Value = 1,
		Keyword = 0,
	},
})

return {
	{
		"saghen/blink.cmp",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("luasnip").config.set_config(opts)
					require("luasnip.loaders.from_vscode").lazy_load()
					require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.vscode_snippets_path or "" })
				end,
			},
		},
		version = "1.*",
		event = "InsertEnter",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "enter",
				["<C-l>"] = { "snippet_forward", "fallback" },
				["<C-h>"] = { "snippet_backward", "fallback" },
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			snippets = { preset = "luasnip" },
			fuzzy = {
				implementation = "prefer_rust_with_warning",
				sorts = {
					"score",
					kind_comparator,
					"label",
					"sort_text",
				},
			},
			signature = { enabled = true }, -- Experimental feature
			sources = {
				default = { "lsp", "buffer", "snippets", "path", "rrnode" },
				providers = {
					rrnode = {
						name = "rrnode",
						module = "configs.blinkcmp.rrsource",
					},
				},
			},
			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 500 },
				menu = {
					draw = {
						columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
					},
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
