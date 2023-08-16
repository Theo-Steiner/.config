local wezterm = require('wezterm')
local config = {}

wezterm.on('toggle-pane', function(current_window, current_pane)
	local current_pane_id = current_pane:pane_id()
	local current_tab = current_window:active_tab()
	local current_tab_pane_ids = current_tab:panes()
	-- if current pane is the only pane in the tab, open a horizontal split pane (for npm run dev etc)
	if #current_tab_pane_ids == 1 then
		current_window:perform_action(
			wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }),
			current_pane
		)
		return
	end
	-- if two panes exist already, get the alternate pane (currently *not* selected pane)
	local alternate_pane = nil
	local alternate_pane_id = nil
	for i, open_pane in ipairs(current_tab_pane_ids) do
		local open_pane_id = open_pane:pane_id()
		if open_pane_id ~= current_pane_id then
			alternate_pane = open_pane
			alternate_pane_id = open_pane_id
		end
	end
	-- if the current pane is the top pane (current id is lower than alternate_id)
	if current_pane_id < alternate_pane_id then
		-- deactivate fullscreen for top pane (current pane)
		current_window:perform_action(
			wezterm.action.SetPaneZoomState(false),
			current_pane
		)
		-- then switch to bottom pane
		alternate_pane:activate()
	else
		-- if the current pane is the bottom pane (current id is lower than alternate_id)
		-- switch to top pane
		alternate_pane:activate()
		-- and make top pane fullscreen
		current_window:perform_action(
			wezterm.action.SetPaneZoomState(true),
			current_pane
		)
	end
end)

-- don't display ugly bar at the top
config.window_decorations = "RESIZE"
config.window_background_opacity = .9
config.macos_window_background_blur = 20
config.window_padding = {
	left = 5,
	right = 5,
	top = 5,
	bottom = 5,
}
config.window_frame = {
	font_size = 16,
	active_titlebar_bg = '#1a1b26',
}

config.keys = {
	{
		key = 'i',
		mods = 'CMD|ALT',
		action = wezterm.action.ActivateCopyMode,
	},

	{
		key = 'l',
		mods = 'CMD',
		action = wezterm.action.EmitEvent('toggle-pane'),
	},
}

config.font = wezterm.font_with_fallback({
	-- Main font
	"Fira Code",
	-- Fallback to Nerd Font symbols if glyph is not available
	"Symbols Nerd Font",
	-- Fallback to JetBrains Mono if glyph still not available (for example: (⇡)[\u21E1])
	"JetBrains Mono",
})
config.font_size = 18

config.color_scheme = 'tokyonight_moon'
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
