local function get_file_name_without_extension(path)
	local name = path:match("^.+/(.+)$") or path
	return name:match("(.+)%..+$") or name
end

local function split_path(path)
	local parts = {}
	for part in path:gmatch("[^/]+") do
		table.insert(parts, part)
	end
	return parts
end

local function earliest_match_start(str, prompt)
	local start_pos = str:lower():find(prompt:lower(), 1, true)
	return start_pos or math.huge
end

local function tiebreak(current, existing, prompt)
	local cur_file = get_file_name_without_extension(current)
	local ex_file = get_file_name_without_extension(existing)

	-- 1. Exact match of file-name without extension
	if cur_file:lower() == prompt:lower() and ex_file:lower() ~= prompt:lower() then
		return true
	elseif ex_file:lower() == prompt:lower() and cur_file:lower() ~= prompt:lower() then
		return false
	end

	-- 2. Earliest match on start of file name
	local cur_file_match = earliest_match_start(cur_file, prompt)
	local ex_file_match = earliest_match_start(ex_file, prompt)
	if cur_file_match ~= ex_file_match then
		return cur_file_match < ex_file_match
	end

	-- 3. Earliest match on start of one of the folder names
	local cur_parts = split_path(current)
	local ex_parts = split_path(existing)
	local cur_folder_match = math.huge
	local ex_folder_match = math.huge

	for _, part in ipairs(cur_parts) do
		local match = earliest_match_start(part, prompt)
		if match < cur_folder_match then
			cur_folder_match = match
		end
	end
	for _, part in ipairs(ex_parts) do
		local match = earliest_match_start(part, prompt)
		if match < ex_folder_match then
			ex_folder_match = match
		end
	end
	if cur_folder_match ~= ex_folder_match then
		return cur_folder_match < ex_folder_match
	end

	-- 4. Shorter text first
	if #current ~= #existing then
		return #current < #existing
	end

	-- 5. Alphanumeric order
	return current:lower() < existing:lower()
end

local options = {
	defaults = {
		vimgrep_arguments = {
			"rg",
			"-L",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix = "   ",
		selection_caret = "  ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { "node_modules" },
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { "truncate" },
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		mappings = {
			n = { ["q"] = require("telescope.actions").close },
		},
		tiebreak = function(current_entry, existing_entry, prompt)
			return tiebreak(current_entry.ordinal, existing_entry.ordinal, prompt)
		end,
		preview = { filesize_limit = 1.0 },
	},

	extensions_list = { "themes", "terms", "fzf" },
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
}

return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		init = function()
			vim.keymap.set("n", "<C-p>", require("telescope.builtin").find_files, { desc = "Find files" })
			vim.keymap.set("n", "<leader>ff", "<cmd> Telescope find_files <CR>", { desc = "Find files" })
			vim.keymap.set("n", "<leader>fg", require("telescope.builtin").git_files, { desc = "Git files" })
			vim.keymap.set("n", "<leader>fr", require("telescope.builtin").registers, { desc = "Find registers" })
			vim.keymap.set("n", "<leader>fw", "<cmd> Telescope live_grep <CR>", { desc = "Live grep" })
			vim.keymap.set("n", "<leader>fb", "<cmd> Telescope buffers <CR>", { desc = "Find buffers" })
			vim.keymap.set("n", "<leader>fh", "<cmd> Telescope help_tags <CR>", { desc = "Help page" })
			vim.keymap.set("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>", { desc = "Find oldfiles" })
			vim.keymap.set("n", "<leader>fm", require("telescope.builtin").marks, { desc = "Find marks" })
			vim.keymap.set(
				"n",
				"<leader>fz",
				"<cmd> Telescope current_buffer_fuzzy_find <CR>",
				{ desc = "Find in current buffer" }
			)
			vim.keymap.set(
				"n",
				"<leader>fa",
				"<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
				{ desc = "Find all" }
			)

			vim.keymap.set("n", "<leader>gc", require("telescope.builtin").git_commits, { desc = "Git commits" })
			vim.keymap.set("n", "<leader>gs", require("telescope.builtin").git_status, { desc = "Git status" })
			vim.keymap.set(
				"n",
				"<leader>cs",
				require("telescope.builtin").lsp_document_symbols,
				{ desc = "Code symbols" }
			)
			vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references, { desc = "LSP references" })
		end,
		config = function()
			require("telescope").setup(options)
		end,
	},
}
