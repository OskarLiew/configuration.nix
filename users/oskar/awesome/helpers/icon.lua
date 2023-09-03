local gears = require("gears")
local wibox = require("wibox")

local function init_icon(image, size, color)
	local naughty = require("naughty")
	naughty.notification({ message = "Hi" })
	image = gears.color.recolor_image(image, color)
	return wibox.widget({
		image = image,
		forced_height = size,
		forced_width = size,
		widget = wibox.widget.imagebox,
	})
end

return {
	init_icon = init_icon,
}
