local awful = require("awful")
local beautiful = require("beautiful")
local icons = require("theme.icons").taglist
local apps = require("configuration.apps")

local tags = {
	{
		type = "term",
		icon = icons.terminal,
		default_app = apps.default.terminal,
		gap = beautiful.useless_gap,
		layout = awful.layout.suit.tile,
	},
	{
		type = "web",
		icon = icons.web_browser,
		default_app = apps.default.web_browser,
		gap = beautiful.useless_gap,
		layout = awful.layout.suit.tile,
	},
	{
		type = "code",
		icon = icons.text_editor,
		default_app = apps.default.text_editor,
		gap = beautiful.useless_gap,
		layout = awful.layout.suit.tile,
	},
	{
		type = "notes",
		icon = icons.notepad,
		default_app = apps.default.notes,
		gap = beautiful.useless_gap,
		layout = awful.layout.suit.tile,
	},
	{
		type = "files",
		icon = icons.file_manager,
		default_app = apps.default.file_manager,
		gap = beautiful.useless_gap,
		layout = awful.layout.suit.tile,
	},
	{
		type = "multimedia",
		icon = icons.multimedia,
		default_app = apps.default.multimedia,
		gap = 0,
		layout = awful.layout.suit.tile,
	},
	{
		type = "sandbox",
		icon = icons.sandbox,
		default_app = apps.default.sandbox,
		layout = awful.layout.suit.tile,
		gap = beautiful.useless_gap,
	},
	{
		type = "meeting",
		icon = icons.meeting,
		layout = awful.layout.suit.tile,
		gap = beautiful.useless_gap,
	},
	{
		type = "chat",
		icon = icons.social,
		default_app = "discord",
		gap = beautiful.useless_gap,
	},
}

-- Set tags layout
tag.connect_signal("request::default_layouts", function()
	awful.layout.append_default_layouts({
		awful.layout.suit.spiral.dwindle,
		awful.layout.suit.tile,
		awful.layout.suit.floating,
		awful.layout.suit.max,
	})
end)

local function restore_windows_to_desired_screen(new_screen)
	for _, c in ipairs(client.get()) do
		if not (c.desired_screen == nil) then
			local tag_name = c.first_tag.name
			c:move_to_screen(c.desired_screen)
			local t = awful.tag.find_by_name(c.screen, tag_name)
			if not (tag == nil) then
				c:move_to_tag(t)
			end
			-- now clear the "desired_screen"
			c.desired_screen = nil
		end
	end
end

-- Create tags for each screen
screen.connect_signal("request::desktop_decoration", function(s)
	for i, tag in pairs(tags) do
		awful.tag.add(tag.type, {
			icon = tag.icon,
			icon_only = true,
			layout = tag.layout or awful.layout.suit.spiral.dwindle,
			gap_single_client = true,
			gap = tag.gap,
			screen = s,
			default_app = tag.default_app,
			selected = i == 1,
			index = i,
		})
	end
	restore_windows_to_desired_screen(s)
end)

-- Focus on urgent clients
awful.tag.attached_connect_signal(nil, "property::selected", function()
	local urgent_clients = function(c)
		return awful.rules.match(c, { urgent = true })
	end
	for c in awful.client.iterate(urgent_clients) do
		if c.first_tag == mouse.screen.selected_tag then
			c:emit_signal("request::activate")
			c:raise()
		end
	end
end)

-- Handle screen being removed.
-- We'll look for same tag names and move clients there, but preserve
-- the "desired_screen" so we can move them back when it's connected.
tag.connect_signal("request::screen", function(t)
	local fallback_tag = nil

	-- find tag with same name on any other screen
	for other_screen in screen do
		if other_screen ~= t.screen then
			fallback_tag = awful.tag.find_by_name(other_screen, t.name)
			if fallback_tag ~= nil then
				break
			end
		end
	end

	-- no tag with same name exists, use fallback
	if fallback_tag == nil then
		fallback_tag = awful.tag.find_fallback()
	end

	if not (fallback_tag == nil) then
		local clients = t:clients()
		for _, c in ipairs(clients) do
			c:move_to_tag(fallback_tag)
			-- preserve info about which screen the window was originally on, so
			-- we can restore it if the screen is reconnected.
			c.desired_screen = t.screen.index
		end
	end
end)
