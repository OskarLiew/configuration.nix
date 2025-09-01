-- Functionality to work navigate in the Red Robin network

local M = {}

---Open a path if it exists
---@param path string
local function edit_if_exists(path)
    local file = io.open(path, "r")

    if file == nil then
        vim.print("File " .. path .. " does not exist")
        return
    end

    file:close()

    path = vim.fn.fnameescape(path)
    vim.api.nvim_command("edit " .. path)

    vim.print("Editing " .. path)
end

M.jump_to_node = function()
    local node = vim.treesitter.get_node()
    local bufnr = vim.api.nvim_get_current_buf()
    local node_text = vim.treesitter.get_node_text(node, bufnr)

    local type = node:type()
    if type:find("integer") ~= nil then
        local path = "network/node_" .. node_text .. ".yaml"
        edit_if_exists(path)
    else
        vim.print("Not a valid NodeID: " .. node_text)
    end
end

---Move cursor to the pattern in the current buffer
---@param pattern string
local function jump_to_pattern(pattern)
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    for row, line in ipairs(lines) do
        local start_col, _ = string.find(line, pattern)
        if start_col then
            -- Pattern found, move the cursor to the matched position
            vim.api.nvim_win_set_cursor(0, { row, start_col })
            return
        end
    end
    vim.print("Pattern " .. pattern .. " not found")
end

---Jump to the texts of the currently hovered node for the given language
---@param language string
M.jump_to_texts = function(language)
    local node = vim.treesitter.get_node()
    local bufnr = vim.api.nvim_get_current_buf()
    local node_text = vim.treesitter.get_node_text(node, bufnr)

    edit_if_exists("network/texts/" .. language .. ".yaml")

    local type = node:type()
    if type:find("integer") ~= nil then
        local pattern = "[^%w]" .. node_text .. ":"
        jump_to_pattern(pattern)
    else
        node_text = node_text:gsub("[%(%)]", "%%%1") -- Escape parentheses
        local pattern = "[^%w]name: " .. node_text
        jump_to_pattern(pattern)
    end
end

local function split(str, sep)
    local result = {}
    for match in str:gmatch("([^" .. sep .. "]+)") do
        table.insert(result, match)
    end
    return result
end

local function entry_maker(entry)
    local split_line = split(entry, ":")
    local file_path = split_line[1]
    local name_id = split_line[#split_line]
    local node_id = string.match(file_path, "node_(%d+).yaml")
    local combined_name = string.format("%s (%s)", name_id, node_id)
    return {
        value = file_path,
        filename = file_path,
        display = combined_name,
        ordinal = combined_name,
        node_id = node_id,
    }
end

local function get_rg_nodes()
    local cmd = {
        "rg",
        "--with-filename",
        "--no-heading",
        "--glob",
        "network/node_*.yaml",
        "-e",
        "name_id: ",
    }
    local result = vim.fn.systemlist(cmd)
    return result
end

function M.quick_scope(opts)
    opts = opts or {}
    opts.entry_maker = opts.entry_maker or entry_maker
    local node_finder = require("telescope.finders").new_table({
        results = get_rg_nodes(),
        entry_maker = opts.entry_maker,
    })

    local insert_node_id = function(prompt_bufnr, _)
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.api.nvim_put({ selection["node_id"] }, "", false, true)
        return true
    end

    local attach_ctrl_enter = function(_, map)
        map("i", "<C-j>", insert_node_id)
        map("n", "<C-j>", insert_node_id)

        return true
    end

    require("telescope.pickers")
        .new({}, {
            prompt_title = "RR - QuickScope",
            finder = node_finder,
            previewer = require("telescope.config").values.grep_previewer(opts),
            sorter = require("telescope.sorters").get_fzy_sorter(),
            attach_mappings = attach_ctrl_enter,
        })
        :find()
end

return M
