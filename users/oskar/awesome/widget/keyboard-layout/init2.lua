local wibox = require("wibox")
local widget = require("awful.widget")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local clickable_container = require("widget.clickable-container")

local gears = require("gears")
local config_dir = gears.filesystem.get_configuration_dir()
local widget_icon_dir = config_dir .. "widget/keyboard-layout/icons/"

local keyboard_imagebox = wibox.widget({
	nil,
	{
		id = "icon",
		image = widget_icon_dir .. "keyboard.svg",
		widget = wibox.widget.imagebox,
		resize = true,
	},
	nil,
	layout = wibox.layout.align.vertical,
})

local keyboard_button = wibox.widget({
	{
		keyboard_imagebox,
		margins = dpi(2),
		widget = wibox.container.margin,
	},
	widget = clickable_container,
})

keyboard_button:buttons(gears.table.join(awful.button({}, 1, nil, function()
	widget.keyboardlayout():next_layout()
end)))

local keyboard_widget = wibox.widget({
	layout = wibox.layout.fixed.horizontal,
	spacing = dpi(0),
	keyboard_button,
	widget.keyboardlayout(),
})

return keyboard_widget
