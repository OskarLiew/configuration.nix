local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

function init_sidebar(s)
	sidebar_shape = function(cr, width, height)
		return gears.shape.partially_rounded_rect(
			cr,
			width,
			height,
			false,
			true,
			false,
			false,
			2 * beautiful.edge_radius
		)
	end

	-- Create panel
	local top_margin = dpi(20)
	local panel = wibox({
		visible = true,
		ontop = true,
		type = "normal",
		height = s.tiling_area.height,
		width = s.geometry.width / 4,
		x = 0,
		y = s.geometry.height - s.tiling_area.height + 2 * beautiful.useless_gap,
		shape = sidebar_shape,
		stretch = false,
		bg = beautiful.bg_dim .. "AA",
		fg = beautiful.fg_normal,
	})

	-- Define widgets
	local big_clock = wibox.widget({
		{
			layout = wibox.layout.fixed.vertical,
			{
				format = "%H:%M",
				align = "center",
				font = "Inter 88",
				widget = wibox.widget.textclock,
			},
			{
				format = "%A %B %d",
				align = "center",
				font = "Inter 28",
				widget = wibox.widget.textclock,
			},
		},
		widget = wibox.container.margin,
	})

	local main_area = wibox.widget({
		{
			widget = wibox.layout.fixed.vertical,
		},
		bg = beautiful.bg_dim .. "90",
		shape = sidebar_shape,
		widget = wibox.container.background,
		forced_height = s.tiling_area.height * 0.77, -- A better way to do this?
	})

	panel:setup({
		{
			layout = wibox.layout.fixed.vertical,
			spacing = dpi(30),
			big_clock,
			main_area,
		},
		top = 20,
		widget = wibox.container.margin,
	})
	return panel
end

return init_sidebar
