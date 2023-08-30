local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local config_dir = gears.filesystem.get_configuration_dir()
local clickable_container = require("widget.clickable-container")
local widget_icon_dir = config_dir .. "widget/music-player/icons/"

local function init_icon(image, size, color)
	image = gears.color.recolor_image(widget_icon_dir .. image, color)
	return wibox.widget({
		image = image,
		forced_height = size,
		forced_width = size,
		widget = wibox.widget.imagebox,
	})
end

function init_music_player()
	-- Create icons
	local play_icon = init_icon("play.svg", dpi(80), beautiful.green)
	local pause_icon = init_icon("pause.svg", dpi(80), beautiful.green)
	local next_icon = init_icon("next.svg", dpi(60), beautiful.green)
	local previous_icon = init_icon("previous.svg", dpi(60), beautiful.green)

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
			spacing = dpi(20),
			expand = "none",
		},
		widget = wibox.container.place,
		valign = "center",
		halign = "center",
	})

	-- Create song and artist view
	local song_title = wibox.widget({
		text = "No song playing",
		font = "Inter, Bold 20",
		halign = "center",
		ellipsize = "end",
		widget = wibox.widget.textbox,
	})

	local artist = wibox.widget({
		text = "Abc Def",
		font = "Inter 14",
		halign = "center",
		ellipsize = "end",
		widget = wibox.widget.textbox,
	})

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
		song_title,
		artist,
		player_controls,
		layout = wibox.layout.fixed.vertical,
		spacing = dpi(10),
	})

	return music_player
end

return init_music_player
