local awful = require("awful")
local modkey = require("configuration.keys.mod").mod_key

client.connect_signal("request::default_keybindings", function()
	awful.keyboard.append_client_keybindings({
		awful.key({ modkey }, "f", function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end, { description = "toggle fullscreen", group = "client" }),
		awful.key({ modkey }, "c", function(c)
			c:kill()
		end, { description = "close", group = "client" }),
		awful.key(
			{ modkey, "Control" },
			"space",
			awful.client.floating.toggle,
			{ description = "toggle floating", group = "client" }
		),
		awful.key({ modkey, "Control" }, "Return", function(c)
			c:swap(awful.client.getmaster())
		end, { description = "move to master", group = "client" }),
		awful.key({ modkey }, "o", function(c)
			-- Move to next screen but keep it in the same tag
			-- Also update the old screen to switch to a tag with clients
			awful.screen.focus_relative(1)
			local old_screen = c.screen
			local new_screen = awful.screen.focused()
			local tags = c:tags()
			local new_tags = {}
			for index, t in ipairs(tags) do
				new_tags[index] = awful.tag.find_by_name(new_screen, t.name)
			end
			c:move_to_screen(new_screen)
			c:tags(new_tags)

			local any_selected = false
			for _, t in ipairs(tags) do
				if #t:clients() == 0 then
					t.selected = false
				else
					any_selected = true
				end
			end

			if not any_selected then
				local any_clients = false
				for _, t in ipairs(old_screen.tags) do
					if #t:clients() > 0 then
						t.selected = true
						any_clients = true
						break
					else
						t.selected = false
					end
				end
				if not any_clients then
					old_screen.tags[1].selected = true
				end
			end
			c:jump_to()
		end, { description = "move to screen", group = "client" }),
		awful.key({ modkey }, "t", function(c)
			c.ontop = not c.ontop
		end, { description = "toggle keep on top", group = "client" }),
		awful.key({ modkey }, "n", function(c)
			-- The client currently has the input focus, so it cannot be
			-- minimized, since minimized clients can't have the focus.
			c.minimized = true
		end, { description = "minimize", group = "client" }),
		awful.key({ modkey }, "m", function(c)
			c.maximized = not c.maximized
			c:raise()
		end, { description = "(un)maximize", group = "client" }),
	})
end)

client.connect_signal("request::default_mousebindings", function()
	awful.mouse.append_client_mousebindings({
		awful.button({}, 1, function(c)
			c:activate({ context = "mouse_click" })
		end),
		awful.button({ modkey }, 1, function(c)
			c:activate({ context = "mouse_click", action = "mouse_move" })
		end),
		awful.button({ modkey }, 3, function(c)
			c:activate({ context = "mouse_click", action = "mouse_resize" })
		end),
		awful.button({ modkey }, 2, function(c)
			c:kill()
		end),
	})
end)
