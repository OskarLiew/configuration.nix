local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")
local gears = require("gears")

local config = require("configuration.widget")

local top_panel = function(s)
	-- Playground
	local offsetx = dpi(45)
	local panel_height = dpi(24)

	local panel_shape = function(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, beautiful.edge_radius)
	end

	-- Create panel
	local panel = wibox({
		visible = true,
		ontop = true,
		screen = s,
		type = "dock",
		height = panel_height,
		width = s.geometry.width - 2 * offsetx,
		x = s.geometry.x + offsetx,
		y = s.geometry.y + 0.2 * panel_height,
		shape = panel_shape,
		stretch = false,
		bg = beautiful.bg_normal .. beautiful.bg_opacity,
		fg = beautiful.fg_normal,
	})

	panel:struts({
		top = panel_height,
	})

	-- Initialize widgets
	local textclock = wibox.widget.textclock()
	local battery = require("widget.battery")()
	local volume = require("widget.volume")()
	local keyboardlayout = require("widget.keyboard-layout")
	local network = require("widget.network")(config.network.wireless_interface)
	s.layoutbox = require("widget.layoutbox")(s)
	s.task_list = require("widget.task-list")(s)
	s.tag_list = require("widget.tag-list")(s)

	s.systray = wibox.widget({
		visible = true,
		base_size = dpi(20),
		horizontal = true,
		screen = "primary",
		widget = wibox.widget.systray,
	})
	local left = {
		{
			wibox.widget.spacing,
			margins = dpi(2),
			widget = wibox.container.margin,
		},
		layout = wibox.layout.fixed.horizontal,
		s.tag_list,
		s.task_list,
	}
	local center = textclock
	local right = {
		layout = wibox.layout.fixed.horizontal,
        spacing = dpi(1),
		{
			s.systray,
			margins = dpi(5),
			widget = wibox.container.margin,
		},
		network,
		volume,
		battery,
		keyboardlayout,
		s.layoutbox,
		{
			wibox.widget.spacing,
			margins = dpi(2),
			widget = wibox.container.margin,
		},
	}
	panel:setup({
		{
			layout = wibox.layout.align.horizontal,
			expand = "none",
			left,
			center,
			right,
		},
		right = dpi(4),
		widget = wibox.container.margin,
	})
	return panel
end

return top_panel