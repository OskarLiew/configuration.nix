local awful = require("awful")
local ruled = require("ruled")

require("layout.titlebar")
require("layout.mymainmenu")

local top_panel = require("layout.top-panel")

screen.connect_signal("request::desktop_decoration", function(s)
	s.top_panel = top_panel(s)
	s.info_center = require("layout.info-center")(s)
end)

-- {{{ Rules
-- Rules to apply to new clients.
ruled.client.connect_signal("request::rules", function()
	-- All clients will match this rule.
	ruled.client.append_rule({
		id = "global",
		rule = {},
		properties = {
			focus = awful.client.focus.filter,
			raise = true,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
			titlebar = true,
		},
	})

	-- Floating clients.
	ruled.client.append_rule({
		id = "floating",
		rule_any = {
			instance = { "copyq", "pinentry" },
			class = {
				"Arandr",
				"Blueman-manager",
				".blueman-manager-wrapped",
				".arandr-wrapped",
				"pavucontrol",
				"Gpick",
				"Kruler",
				"Sxiv",
				"Tor Browser",
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
				"SimpleScreenRecorder",
				"Nautilus",
				"BoltLauncher",
			},
			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
			type = {
				"dialog", -- Commonly used for popups
				"popup_menu",
				"toolbar",
				"notification",
			},
		},
		properties = {
			floating = true,
		},
	})

	-- Clients that should never have titlebar
	ruled.client.append_rule({
		id = "no-titlebar",
		rule_any = {
			type = {
				"splash",
			},
			requests_no_titlebar = true,
		},
		properties = {
			titlebar = false,
		},
	})

	-- Center floating
	ruled.client.append_rule({
		id = "floating-location",
		rule_any = {
			floating = true,
		},
		properties = {
			placement = awful.placement.centered + awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	})
end)
-- }}}
