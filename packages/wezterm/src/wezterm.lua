local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Gruvbox Dark (Gogh)"
config.font = wezterm.font("Fira Code Nerd Font")
config.font_size = 11
config.front_end = "WebGpu"

config.window_padding = {
	left = 0,
	right = 0,
}
config.window_background_opacity = 0.8

local act = wezterm.action
config.keys = {
	{
		key = "w",
		mods = "CTRL",
		action = act.ActivateKeyTable({
			name = "switch_pane",
			timeout_milliseconds = 1000,
		}),
	},
}

config.key_tables = {
	switch_pane = {
		{ key = "h", action = act.ActivatePaneDirection("Left") },
		{ key = "j", action = act.ActivatePaneDirection("Down") },
		{ key = "k", action = act.ActivatePaneDirection("Up") },
		{ key = "l", action = act.ActivatePaneDirection("Right") },
		{ key = "w", action = act.EmitEvent("rotate-pane") },
		{ key = "w", mods = "CTRL",                              action = act.EmitEvent("rotate-pane") },
	},
}

wezterm.on("rotate-pane", function(window, pane)
	local panes = window:mux_window():active_tab():panes()

	local next = pane:pane_id() + 1

	if next >= #panes then
		next = 0
	end

	window:perform_action(act.ActivatePaneByIndex(next), pane)
end)

config.default_prog = { "nu" }

return config
