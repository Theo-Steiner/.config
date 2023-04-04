local wezterm = require('wezterm')
local config = {}

-- don't display ugly bar at the top
config.window_decorations = "RESIZE"
config.window_background_opacity = .7
config.macos_window_background_blur = 20
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
-- use thin tabs
config.use_fancy_tab_bar = false

config.font = wezterm.font('FiraCode Nerd Font Mono')

config.color_scheme = 'tokyonight_moon'
config.font_size = 18
config.window_background_gradient = {
	colors = { '#1a1b26', '#414868' },
	-- Specifices a Linear gradient starting in the top left corner.
	orientation = { Linear = { angle = -45.0 } },
}

return config
