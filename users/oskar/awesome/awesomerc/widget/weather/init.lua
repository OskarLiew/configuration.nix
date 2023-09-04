local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local naughty = require("naughty")

local clickable_container = require("widget.clickable-container")

local icon_dir = require("helpers.widget").get_icon_dir("weather")
local init_icon = require("helpers.icon").init_icon
local read_file = require("helpers.io").read_file

local config = require("configuration.widget").weather
local token = read_file(config.api_key_path):gsub("\n", "")

local json = require("cjson")

local function convert_temp(degrees_k)
	local degrees_c = tonumber(degrees_k) - 273.15
	return string.format("%.0f", degrees_c) .. "°"
end

local function get_weather_icon(icon_code)
	local mapping = {
		["01d"] = "sun.svg",
		["01n"] = "moon.svg",
		["02d"] = "sunny.svg",
		["02n"] = "cloudy-night.svg",
		["03d"] = "cloudy.svg",
		["03n"] = "cloudy-night.svg",
		["04d"] = "cloud.svg",
		["04n"] = "cloud-dark.svg",
		["09d"] = "light-rain.svg",
		["09n"] = "light-rain-dark.svg",
		["10d"] = "heavy-rain.svg",
		["10n"] = "heavy-rain-dark.svg",
		["11d"] = "thunderstorm.svg",
		["11n"] = "thunderstorm-dark.svg",
		["13d"] = "snow.svg",
		["13n"] = "snow-dark.svg",
		["50d"] = "fog.svg",
		["50n"] = "fog-dark.svg",
	}
	return mapping[icon_code]
end

local icon_stylesheet = ""
	.. ".sun { stroke:"
	.. beautiful.yellow
	.. "; fill:"
	.. beautiful.yellow
	.. ";} "
	.. ".moon { stroke:"
	.. beautiful.blue
	.. "; fill:"
	.. beautiful.blue
	.. ";} "
	.. ".cloud { stroke:"
	.. beautiful.fg
	.. ";}"
	.. ".cloud-dark { stroke:"
	.. beautiful.gray2
	.. ";}"
	.. ".lightning { stroke:"
	.. beautiful.yellow
	.. ";}"
	.. ".fog { stroke:"
	.. beautiful.blue
	.. ";}"
	.. ".snow { stroke:"
	.. beautiful.blue
	.. ";}"
	.. ".rain {stroke:"
	.. beautiful.blue
	.. ";}"
	.. ".error {stroke:"
	.. beautiful.red
	.. ";}"

local function init_weather_widget()
	local current_weather_desc = wibox.widget({
		text = "No data",
		font = "Inter 20",
		align = "center",
		widget = wibox.widget.textbox,
	})

	local current_weather_icon = init_icon(icon_dir .. "error.svg", dpi(54))
	current_weather_icon.stylesheet = icon_stylesheet

	local current_weather_temp = wibox.widget({
		text = "",
		font = "Inter 20",
		align = "left",
		widget = wibox.widget.textbox,
	})

	local token = read_file(config.api_key_path):gsub("\n", "")
	local current_weather_cmd = [[sh -c "curl 'http://api.openweathermap.org/data/2.5/weather?q=]]
		.. config.location
		.. [[&APPID=]]
		.. token
		.. [['"]]

	awful.widget.watch(current_weather_cmd, 60 * 60 * 30, function(widget, stdout, stderr, exitreason, exitcode)
		if exitcode == 0 then
			current_weather_data = json.decode(stdout)
			if current_weather_data.cod == 200 then
				current_weather_temp.text = convert_temp(current_weather_data.main.temp)
				current_weather_desc.text = current_weather_data.weather[1].description:gsub("^%l", string.upper)
				current_weather_icon.image = icon_dir .. get_weather_icon(current_weather_data.weather[1].icon)
			else
				current_weather_icon.image = icon_dir .. "error.svg"
				current_weather_desc.text = "Error"
				naughty.notification({
					message = "Error in weather widget: " .. current_weather_data.message,
					urgency = "critical",
				})
			end
		else
			current_weather_icon.image = icon_dir .. "error.svg"
			current_weather_desc.text = "Error"
			naughty.notification({ message = "Error in weather widget: " .. stderr, urgency = "critical" })
		end
	end)

	local current_weather = wibox.widget({
		current_weather_desc,
		{
			{
				current_weather_icon,
				current_weather_temp,
				layout = wibox.layout.fixed.horizontal,
				spacing = dpi(20),
			},
			widget = wibox.container.place,
			halign = "center",
		},
		layout = wibox.layout.fixed.vertical,
		spacing = dpi(10),
	})

	local weather_widget = wibox.widget({
		current_weather,
		layout = wibox.layout.fixed.vertical,
	})

	return weather_widget
end

return init_weather_widget
