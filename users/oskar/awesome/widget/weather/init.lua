local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local clickable_container = require("widget.clickable-container")

local icon_dir = require("helpers.widget").get_icon_dir("music-player")
local init_icon = require("helpers.icon").init_icon

local config = require("configuration.widget").weather

local function init_weather_widget() end

return init_weather_widget
