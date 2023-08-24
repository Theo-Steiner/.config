local wezterm = require('wezterm')

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
	for _, open_pane in ipairs(current_tab_pane_ids) do
		local open_pane_id = open_pane:pane_id()
		if open_pane_id ~= current_pane_id then
			alternate_pane = open_pane
			alternate_pane_id = open_pane_id
		end
	end
	-- if the current pane is the top pane (current id is lower than alternate_id)
	if current_pane_id < alternate_pane_id then
		-- toggle fullscreen for top pane (if alternate pane is hidden, show it)
		current_window:perform_action(
			wezterm.action.TogglePaneZoomState,
			current_pane
		)
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

return {
	-- don't display ugly bar at the top
	window_decorations = "RESIZE",
	window_background_opacity = .9,
	macos_window_background_blur = 20,
	window_padding = {
		left = 5,
		right = 5,
		top = 5,
		bottom = 5,
	},
	window_frame = {
		font_size = 16,
		active_titlebar_bg = '#1a1b26',
	},
	window_background_gradient = {
		colors = { '#1a1b26', '#414868' },
		-- Specifices a Linear gradient starting in the top left corner.
		orientation = { Linear = { angle = -45.0 } },
	},
	unzoom_on_switch_pane = false,
	inactive_pane_hsb = {
		saturation = 1,
		brightness = .3,
	},
	keys = {
		-- bind wezterm copy mode to inspector hotkey
		{
			key = 'i',
			mods = 'CMD|ALT',
			action = wezterm.action.ActivateCopyMode,
		},
		-- trigger custom split pane toggle with cmd + l
		{
			key = 'l',
			mods = 'CMD',
			action = wezterm.action.EmitEvent('toggle-pane'),
		},
		-- show or hide custom split pane toggle with cmd + l
		{
			key = 'k',
			mods = 'CMD',
			action = wezterm.action.ActivatePaneDirection('Next'),
		},
	},
	font = wezterm.font_with_fallback({
		-- Main font
		"Fira Code",
		-- Fallback to Nerd Font symbols if glyph is not available
		"Symbols Nerd Font",
	}),
	font_size = 18,
	color_scheme = 'tokyonight_moon',
	colors = {
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
}
