return {
	{
		"lukas-reineke/indent-blankline.nvim",
		init = function()
			vim.keymap.set("n", "<leader>cc", function()
				local buf = vim.api.nvim_get_current_buf()
				local conf = require("ibl.config").get_config(buf)
				local scope = require("ibl.scope").get(buf, conf)
				if not scope then
					return nil
				end

				local scope_start_row, scope_start_col = scope:start()

				vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { scope_start_row + 1, scope_start_col })
				vim.cmd([[normal! _]])
			end, { desc = "Jump to current context" })
		end,
		main = "ibl",
		opts = {
			whitespace = {
				remove_blankline_trail = true,
			},
			scope = {
				enabled = false,
			},
		},
	},
}
