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

config.default_prog = { "nu" }

return config
