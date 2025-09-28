return {
	{
		"lewis6991/gitsigns.nvim",
		ft = { "gitcommit", "diff" },
		init = function()
			-- load gitsigns only when a git file is opened
			vim.api.nvim_create_autocmd({ "BufRead" }, {
				group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
				callback = function()
					vim.fn.system("git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse")
					if vim.v.shell_error == 0 then
						vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
						vim.schedule(function()
							require("lazy").load({ plugins = { "gitsigns.nvim" } })
						end)
					end
				end,
			})
		end,
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "󰍵" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "│" },
				},
				on_attach = function(bufnr)
					-- Navigation through hunks
					vim.keymap.set("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							require("gitsigns").next_hunk()
						end)
						return "<Ignore>"
					end, { desc = "Next hunk", expr = true, buffer = bufnr })
					vim.keymap.set("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							require("gitsigns").next_hunk()
						end)
						return "<Ignore>"
					end, { desc = "Previous hunk", expr = true, buffer = bufnr })

					-- Actions
					vim.keymap.set("n", "<leader>gr", function()
						require("gitsigns").reset_hunk()
					end, { desc = "Reset hunk" })

					vim.keymap.set("n", "<leader>gp", function()
						require("gitsigns").preview_hunk()
					end, { desc = "Preview hunk" })

					vim.keymap.set("n", "<leader>gb", function()
						package.loaded.gitsigns.blame_line()
					end, { desc = "Blame line" })

					vim.keymap.set("n", "<leader>gD", function()
						require("gitsigns").toggle_deleted()
					end, { desc = "Toggle deleted" })
				end,
			})
		end,
	},
}
