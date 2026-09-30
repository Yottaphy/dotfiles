---@module 'hl'

-- See https://wiki.hyprland.org/Configuring/Keywords/ for more

-- For all categories, see https://wiki.hyprland.org/Configuring/Variables/

hl.config({
	input = {
		kb_layout = "gb",
		numlock_by_default = true,
		follow_mouse = 1,
		touchpad = {
			natural_scroll = false,
		},
		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
	},
})

hl.config({
	general = {
		-- See https://wiki.hyprland.org/Configuring/Variables/ for more
		gaps_in = 5,
		gaps_out = 10,
		border_size = 2,
		--col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
		layout = "dwindle",
		col = {
			active_border = "rgb(cdd6f4)",
			inactive_border = "rgba(595959aa)",
		},
	},
})

hl.config({
	misc = {
		disable_hyprland_logo = true,
		focus_on_activate = true,
	},
})

hl.config({
	animations = {
		enabled = true,
		-- Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
	},
})
hl.curve("myBezier", {
	type = "bezier",
	points = { { 0.10, 0.9 }, { 0.1, 1.05 } },
})
hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })

hl.config({
	dwindle = {
		-- See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
		--pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
		preserve_split = true, -- you probably want this
	},
})

-- LOAD OTHER CONFIG FILES
package.path = package.path .. ";./?.lua;./?/init.lua"
local smw = require("plugins.split-monitor-workspaces")
local monitors = require("monitors")
local keybinds = require("keybinds")
local media_binds = require("media_binds")
local env_var = require("env_var")

-- AUTOSTART
hl.on("hyprland.start", function()
	hl.exec_cmd("~/.config/hypr/xdg-portal-hyprland")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	-- Wallpaper daemon
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("awww img ~/Pictures/Wallpaper/Jyv.png")
	-- Notifications manager
	hl.exec_cmd("mako")
	-- Instant Eyedropper
	hl.exec_cmd("ie-r")
	-- Bluetooth applet
	hl.exec_cmd("blueman-applet")
	hl.exec_cmd("nm-applet --indicator")
	-- Clipboard
	hl.exec_cmd("wl-paste --watch cliphist store")
	-- Battery notification script
	hl.exec_cmd("~/.config/scripts/batterynotification.sh")
	-- Connect Switch Pro Controller
	hl.exec_cmd("~/.config/scripts/pro-controller-autoconnect.sh")
	hl.exec_cmd("killall waybar; waybar")
end)

-- Exec (run every reload)
hl.on("config.reloaded", function()
	-- Reload waybar on every hyprland reload
	hl.exec_cmd("killall waybar; waybar")
end)
