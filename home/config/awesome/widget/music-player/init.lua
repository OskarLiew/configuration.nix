local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local clickable_container = require("widget.clickable-container")

local icon_helpers = require("helpers.icon")

local icons = beautiful.icons.audio

local function init_music_player(with_icon)
	-- Create icons
	local play_icon = icon_helpers.init_icon(icons.play, dpi(80), beautiful.green)
	local pause_icon = icon_helpers.init_icon(icons.pause, dpi(80), beautiful.green)
	local next_icon = icon_helpers.init_icon(icons.next, dpi(60), beautiful.green)
	local previous_icon = icon_helpers.init_icon(icons.previous, dpi(60), beautiful.green)

	-- Create buttons
	local play_pause_button = wibox.widget({
		play_icon,
		widget = clickable_container,
	})
	play_pause_button:buttons(gears.table.join(awful.button({}, 1, nil, function()
		awesome.emit_signal("daemon::playerctl-play-pause")
	end)))

	local next_button = wibox.widget({
		next_icon,
		widget = clickable_container,
	})
	next_button:buttons(gears.table.join(awful.button({}, 1, nil, function()
		awesome.emit_signal("daemon::playerctl-next")
	end)))

	local previous_button = wibox.widget({
		previous_icon,
		widget = clickable_container,
	})
	previous_button:buttons(gears.table.join(awful.button({}, 1, nil, function()
		awesome.emit_signal("daemon::playerctl-previous")
	end)))

	-- Create controls
	local player_controls = wibox.widget({
		{
			{
				previous_button,
				valign = true,
				forced_height = play_icon.forced_width,
				forced_width = play_icon.forced_height,
				widget = wibox.container.place,
			},
			play_pause_button,
			{
				next_button,
				valign = true,
				forced_height = play_icon.forced_width,
				forced_width = play_icon.forced_height,
				widget = wibox.container.place,
			},
			layout = wibox.layout.fixed.horizontal,
			spacing = dpi(12),
			expand = "none",
		},
		widget = wibox.container.place,
		valign = "center",
		halign = "center",
	})

	-- Create song and artist view
	local song_title = wibox.widget({
		text = "Nothing playing...",
		font = "Inter, Bold 20",
		halign = "center",
		ellipsize = "end",
		forced_height = dpi(30),
		widget = wibox.widget.textbox,
	})

	local artist = wibox.widget({
		text = "...",
		font = "Inter 14",
		halign = "center",
		ellipsize = "end",
		forced_height = dpi(21),
		widget = wibox.widget.textbox,
	})

	local album_art_container = nil
	if with_icon then
		local album_art = wibox.widget({
			widget = wibox.widget.imagebox,
			image = icon_helpers.recolor_image(icons.music, beautiful.fg),
			clip_shape = function(cr, w, h)
				gears.shape.rounded_rect(cr, w, h, dpi(18))
			end,
		})

		local prev_art_url = nil
		awesome.connect_signal("daemon::playerctl", function(status)
			if status.art_url == prev_art_url then
				return
			end

			icon_helpers.fetch_image(status.art_url, function(icon)
				album_art:set_image(icon or icons.music)

				if icon then
					prev_art_url = status.art_url
				end
			end)
		end)
		album_art_container = wibox.widget({
			album_art,
			widget = wibox.container.margin,
			margins = dpi(12),
		})
	end

	-- Logic
	awesome.connect_signal("daemon::playerctl", function(status)
		song_title.text = status.title
		artist.text = status.artist
		if status.status == "paused" then
			play_pause_button.widget = play_icon
		elseif status.status == "playing" then
			play_pause_button.widget = pause_icon
		end
	end)

	-- Create the final widget
	local music_player = wibox.widget({
		album_art_container,
		song_title,
		artist,
		player_controls,
		layout = wibox.layout.fixed.vertical,
		spacing = dpi(6),
	})

	return music_player
end

return init_music_player
