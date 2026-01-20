local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
local icons = beautiful.icons.network

-- Helper: detect the active network interface (e.g., wlan0, eth0)
local function get_active_interface(callback)
	local cmd = "ip route get 8.8.8.8 | awk '{for(i=1;i<=NF;i++) if($i==\"dev\") print $(i+1)}'"
	awful.spawn.easy_async_with_shell(cmd, function(stdout)
		local iface = stdout:match("(%S+)")
		callback(iface or "unknown")
	end)
end

local function start_network_daemon()
	local refresh_rate = 5 -- seconds
	local connected_prev = nil

	local function show_disconnected_notification()
		naughty.notification({
			icon = icons.wifi_disconnected,
			app_name = "System",
			title = "Disconnection",
			message = "You have disconnected from a network",
			urgency = "normal",
		})
	end

	local function show_connected_notification()
		naughty.notification({
			icon = icons.wifi_high,
			app_name = "System",
			title = "Connection",
			message = "You have connected to a network",
			urgency = "normal",
		})
	end

	-- Get signal strength and emit signal
	local function get_network_signal_and_emit()
		get_active_interface(function(interface)
			if not interface or interface == "unknown" then
				awesome.emit_signal("daemon::network-strength", nil, "unknown")
				return
			end

			-- Check if it's a wireless interface
			local cmd = "iwconfig "
				.. interface
				.. [[ 2>/dev/null | awk '/Link Quality=/ {print $2}' | tr -d 'Quality=']]
			awful.spawn.easy_async_with_shell(cmd, function(stdout)
				local numer, denom = stdout:match("([^/]+)/([^ ]+)")
				local network_strength = nil
				if numer and denom then
					network_strength = tonumber(numer) / tonumber(denom)
				end
				awesome.emit_signal("daemon::network-strength", interface, network_strength)
			end)
		end)
	end

	-- Watch connectivity status periodically
	awful.widget.watch("ip route get 8.8.8.8", refresh_rate, function(widget, stdout)
		local connected = stdout and stdout ~= ""
		if connected then
			get_network_signal_and_emit()
		end

		if connected_prev ~= nil then
			if connected and not connected_prev then
				show_connected_notification()
				awesome.emit_signal("daemon::network-connected")
			elseif not connected and connected_prev then
				show_disconnected_notification()
				awesome.emit_signal("daemon::network-disconnected")
			end
		end

		connected_prev = connected
	end)
end

return start_network_daemon()
