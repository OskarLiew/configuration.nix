local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")
local awful = require("awful")

local config = require("configuration.widget")

-- Settings
local panel_height = dpi(30)
local widget_spacing = 0.1 * panel_height
local widget_margins = 0.1 * panel_height
local icon_margins = 0.1 * panel_height

local top_panel = function(s)
	-- Initialize widgets
	s.textclock = wibox.widget.textclock("%H:%M")
	s.battery = require("widget.battery")()
	s.volume = require("widget.volume")()
	s.mic = require("widget.microphone")()
	s.keyboardlayout = require("widget.keyboard-layout")
	s.network = require("widget.network")(config.network.wireless_interface)
	s.systray = require("widget.systray")(panel_height - 2 * icon_margins - 2 * widget_margins)

	-- Create panel
	local panel = awful.wibar({
		visible = true,
		ontop = false,
		position = "top",
		screen = s,
		type = "dock",
		stretch = true,
		bg = beautiful.bg_dim .. beautiful.bg_opacity2,
	})

	panel:struts({
		top = panel.height,
	})

	-- Initialize screen-specific widgets
	s.layoutbox = require("widget.layoutbox")(s)
	s.tag_list = require("widget.tag-list")(s, {
		spacing = widget_spacing,
		margins = icon_margins,
	})

	-- Create layouts
	local left = {
		{
			s.tag_list,
			widget = wibox.layout.fixed.horizontal,
		},
		widget = wibox.container.margin,
		margins = widget_margins,
	}

	local center = wibox.widget({
		widget = wibox.container.margin,
	})

	local right_widgets = {
		s.systray,
		s.network,
		s.volume,
		s.mic,
		s.battery,
		s.keyboardlayout,
		s.layoutbox,
		wibox.widget({
			s.textclock,
			widget = wibox.container.margin,
			left = 2 * widget_spacing,
		}),
	}
	local right_widgets_layout = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		spacing = widget_spacing,
	})

	for _, w in ipairs(right_widgets) do
		local widget = wibox.widget({
			{
				w,
				widget = wibox.container.margin,
				margins = icon_margins,
			},
			widget = wibox.container.background,
			visible = w.visible,
		})
		-- Hide when child is empty or invisible
		w:connect_signal("widget::redraw_needed", function()
			widget.visible = w.visible
		end)
		right_widgets_layout:add(widget)
	end

	local right = {
		right_widgets_layout,
		widget = wibox.container.margin,
		margins = widget_margins,
	}
	panel:setup({
		{
			{
				layout = wibox.layout.align.horizontal,
				expand = "none",
				left,
				center,
				right,
			},
			widget = wibox.container.margin,
			left = beautiful.useless_gap,
			right = beautiful.useless_gap,
		},
		widget = wibox.container.background,
	})

	return panel
end

return top_panel
