local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Gruvbox Dark (Gogh)"
config.font = wezterm.font("Fira Code Nerd Font")
config.font_size = 10.5
config.front_end = "WebGpu"

config.default_cursor_style = "SteadyBar"

config.default_prog = { "nu" }

return config
