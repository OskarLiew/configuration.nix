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
		name_id = name_id,
	}
end

--- @module 'blink.cmp'
--- @class blink.cmp.Source
local source = {}

function source.new(opts)
	local self = setmetatable({}, { __index = source })
	self.opts = opts
	return self
end

function source:enabled()
	local fname = vim.fn.expand("%")
	local match = fname:match("node_%d+")
	if match then
		return true
	end
	return false
end

function source:get_completions(ctx, callback)
	-- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#completionItem
	--- @type lsp.CompletionItem[]
	local items = {}
	local nodes = get_rg_nodes()
	for _, node in ipairs(nodes) do
		local entry = entry_maker(node)

		--- @type lsp.CompletionItem
		local item = {
			label = entry.display,
			kind = require("blink.cmp.types").CompletionItemKind.Value,
			insertText = entry.node_id,
			insertTextFormat = vim.lsp.protocol.InsertTextFormat.PlainText,
		}
		table.insert(items, item)
	end

	callback({
		items = items,
		is_incomplete_backward = false,
		is_incomplete_forward = false,
	})
end

return source
