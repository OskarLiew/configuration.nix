return {

	{
		"hrsh7th/nvim-cmp",
		enabled = false,
		event = "InsertEnter",
		dependencies = {
			{
				-- snippet plugin
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("luasnip").config.set_config(opts)

					-- vscode format
					require("luasnip.loaders.from_vscode").lazy_load()
					require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.vscode_snippets_path or "" })

					-- snipmate format
					require("luasnip.loaders.from_snipmate").load()
					require("luasnip.loaders.from_snipmate").lazy_load({ paths = vim.g.snipmate_snippets_path or "" })

					-- lua format
					require("luasnip.loaders.from_lua").load()
					require("luasnip.loaders.from_lua").lazy_load({ paths = vim.g.lua_snippets_path or "" })

					vim.api.nvim_create_autocmd("InsertLeave", {
						callback = function()
							if
								require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
								and not require("luasnip").session.jump_active
							then
								require("luasnip").unlink_current()
							end
						end,
					})
				end,
			},

			-- autopairing of (){}[] etc
			{
				"windwp/nvim-autopairs",
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)
				end,
			},

			-- cmp sources plugins
			{
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
			},
		},
		config = function()
			local cmp = require("cmp")

			local luasnip = require("luasnip")

			local function border(hl_name)
				return {
					{ "╭", hl_name },
					{ "─", hl_name },
					{ "╮", hl_name },
					{ "│", hl_name },
					{ "╯", hl_name },
					{ "─", hl_name },
					{ "╰", hl_name },
					{ "│", hl_name },
				}
			end

			local function lspkind_comparator(conf)
				local lsp_types = require("cmp.types").lsp
				return function(entry1, entry2)
					if entry1.source.name ~= "nvim_lsp" then
						if entry2.source.name == "nvim_lsp" then
							return false
						else
							return nil
						end
					end
					local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
					local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]

					local priority1 = conf.kind_priority[kind1] or 0
					local priority2 = conf.kind_priority[kind2] or 0
					if priority1 == priority2 then
						return nil
					end
					return priority2 < priority1
				end
			end

			local options = {
				completion = {
					completeopt = "menu,menuone",
				},

				window = {
					completion = {
						side_padding = true,
						winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
						scrollbar = false,
						border = border("CmpBorder"),
					},
					documentation = {
						border = border("CmpDocBorder"),
						winhighlight = "Normal:CmpDoc",
					},
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind =
							require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    (" .. (strings[2] or "") .. ")"

						return kind
					end,
				},

				mapping = {
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					}),
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "luasnip" },
					{ name = "buffer", keyword_length = 5 },
					{ name = "nvim_lua" },
				},

				sorting = {
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						-- Special rules for underscore methods
						function(entry1, entry2)
							local _, entry1_under = entry1.completion_item.label:find("^_+")
							local _, entry2_under = entry2.completion_item.label:find("^_+")
							entry1_under = entry1_under or 0
							entry2_under = entry2_under or 0
							if entry1_under > entry2_under then
								return false
							elseif entry1_under < entry2_under then
								return true
							end
						end,
						lspkind_comparator({
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
						}),
						cmp.config.compare.locality,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
					},
				},
			}
		end,
	},
}
