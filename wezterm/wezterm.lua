local wezterm = require('wezterm')
local config = {}

-- don't display ugly bar at the top
config.window_decorations = "RESIZE"
config.window_background_opacity = .8
config.macos_window_background_blur = 20
config.window_padding = {
	left = 5,
	right = 5,
	top = 5,
	bottom = 5,
}
config.window_frame = {
	font = wezterm.font { family = 'Roboto', weight = 'Bold' },
	font_size = 16,
	active_titlebar_bg = '#1a1b26',
}

config.keys = {
	{
		key = 'i',
		mods = 'CMD|ALT',
		action = wezterm.action.ActivateCopyMode,
	},
}

config.font = wezterm.font('FiraCode Nerd Font Mono')

config.color_scheme = 'tokyonight_moon'
config.font_size = 18
config.window_background_gradient = {
	colors = { '#1a1b26', '#414868' },
	-- Specifices a Linear gradient starting in the top left corner.
	orientation = { Linear = { angle = -45.0 } },
}
config.colors = {
	tab_bar = {
		active_tab = {
			bg_color = '#414868',
			fg_color = '#fefefe',
		},
		inactive_tab = {
			bg_color = '#1a1b26',
			fg_color = '#808080',
		},
		new_tab = {
			bg_color = '#1a1b26',
			fg_color = '#fefefe',
		},
		inactive_tab_edge = '#1a1b26',
	},
}

return config
