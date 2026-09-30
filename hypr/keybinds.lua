-- @module 'hl'
local smw = require("plugins.split-monitor-workspaces")

-- MAIN HYPRLAND BINDS
hl.bind("SUPER + R", hl.dsp.exec_cmd("hyprctl reload")) -- reload hyprland
hl.bind("SUPER + Q", hl.dsp.window.close()) -- close the active window
hl.bind("SUPER + ESCAPE", hl.dsp.exec_cmd("wlogout --protocol layer-shell")) -- show the logout window
hl.bind("SUPER + SHIFT + ESCAPE", hl.dsp.exit()) -- Exit Hyprland all together no (force quit Hyprland)
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd("swaylock")) -- Lock the screen

-- VOLUME CONTROLS
hl.bind("PRINT", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/HyprV/waybar/scripts/volume --toggle"))
hl.bind("SCROLL_LOCK", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/HyprV/waybar/scripts/volume --dec"))
hl.bind("PAUSE", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.config/HyprV/waybar/scripts/volume --inc"))

-- TERMINAL
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("alacritty")) --open the terminal
hl.bind("SUPER + SHIFT + RETURN", hl.dsp.exec_cmd("[float;center] alacritty")) --open the terminal as a floating window

-- FILE BROWSERS
hl.bind("SUPER + Y", hl.dsp.exec_cmd("alacritty -e yazi")) -- open the terminal file browser
hl.bind("SUPER + SHIFT + Y", hl.dsp.exec_cmd("[float;center] alacritty -e yazi")) --open the terminal file browser as a floating window
hl.bind("SUPER + N", hl.dsp.exec_cmd("nemo")) -- open the graphical file browser
hl.bind("SUPER + SHIFT + N", hl.dsp.exec_cmd("[float;center] nemo")) -- open the graphical file browser as a floating window

-- APPLICATIONS
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("wofi")) -- Show the graphical app launcher
hl.bind("SUPER + W", hl.dsp.exec_cmd("firefox")) -- open the web browser
hl.bind("SUPER + E", hl.dsp.exec_cmd("thunderbird")) -- open the email client
hl.bind("SUPER + D", hl.dsp.exec_cmd("pkill -SIGUSR1 ie-r")) -- instant eyedropper
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("slurp | grim -g - - | wl-copy")) -- take a screenshot
hl.bind("SUPER + ALT" .. " + " .. "V", hl.dsp.exec_cmd("cliphist list | wofi -dmenu | cliphist decode | wl-copy")) -- open clipboard manager
hl.bind("SUPER + ALT" .. " + " .. "E", hl.dsp.exec_cmd("rofimoji --selector wofi")) -- open rofimoji

--------------------------------------------------------------------------
-- WINDOW MOVEMENTS
--------------------------------------------------------------------------

hl.bind("SUPER + F", hl.dsp.window.float()) -- Allow a window to float
hl.bind("SUPER + P", hl.dsp.window.pseudo()) -- pseudotiling
hl.bind("SUPER + M", hl.dsp.window.fullscreen({ mode = 1 })) -- toggle window fullscreen

hl.bind("SUPER + C", function()
	hl.dispatch(hl.dsp.window.cycle_next()) -- cycle to next window
	hl.dispatch(hl.dsp.window.bring_to_top()) -- bring it to the top
end)

hl.bind("SUPER + SHIFT + C", hl.dsp.window.cycle_next({ next = false })) -- cycle through windows backwards
hl.bind("SUPER + SHIFT + C", hl.dsp.window.bring_to_top()) -- bring backwards-cycled window to top

-- CHANGE WINDOW FOCUS WITHIN WORKSPACE
hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))

-- CHANGE WORKSPACE FOCUS WITHIN MONITOR
for i = 1, smw.get_amount_of_workspaces() do
	local n = tostring(i)
	if n == "10" then
		n = "0"
	end -- Optional if you configured 10 workspaces: bind workspace 10 to SUPER + 0
	-- Switch to the Nth workspace on the currently focused monitor.
	hl.bind("SUPER +" .. n, smw.workspace(n))
	-- Move the active window to the Nth workspace on the currently focused monitor silently (no focus change).
	hl.bind("SUPER + SHIFT +" .. n, smw.move_to_workspace_silent(n))
end
hl.bind("SUPER + TAB", hl.dsp.focus({ workspace = "previous" }))

hl.config({
	binds = {
		workspace_back_and_forth = false,
		allow_workspace_cycles = true,
	},
}) -- Allow for back and forth of workspaces

-- SCROLL WORKSPACES WITH MOUSE SCROLL
hl.bind("SUPER + mouse_down", smw.cycle_workspaces("next"))
hl.bind("SUPER + mouse_up", smw.cycle_workspaces("prev"))
hl.bind("SUPER + SHIFT + mouse_down", smw.move_to_workspace_silent("next"))
hl.bind("SUPER + SHIFT + mouse_up", smw.move_to_workspace_silent("prev"))

-- CHANGE MONITOR FOCUS
hl.bind("SUPER + KP_Subtract", hl.dsp.focus({ monitor = "+1" }))
hl.bind("SUPER + KP_Multiply", hl.dsp.focus({ monitor = "-1" }))

-- MOVE WINDOW TO ANOTHER MONITOR
hl.bind("SUPER + SHIFT + KP_Subtract", hl.dsp.window.move({ monitor = "+1", follow = true }))
hl.bind("SUPER + SHIFT + KP_Multiply", hl.dsp.window.move({ monitor = "-1", follow = true }))

-- RESCUE ORPHANED WINDOWS
hl.bind("SUPER + G", smw.grab_rogue_windows())

-- MOVE AND RESIZE WINDOWS WITH MOUSE BUTTONS
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- GESTURES
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({
	fingers = 2,
	direction = "pinchout",
	mods = "SUPER",
	action = function()
		hl.dispatch(hl.dsp.window.float({ action = "unset" })) -- tile
	end,
})
hl.gesture({
	fingers = 2,
	direction = "pinchin",
	mods = "SUPER",
	action = function()
		hl.dispatch(hl.dsp.window.float({ action = "set" })) -- tile
	end,
})
