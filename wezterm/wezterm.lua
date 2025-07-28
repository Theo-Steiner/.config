local wezterm = require("wezterm")

--- creates a second pane if there is only one pane in the current tab
---@param current_window any
---@param current_pane any
---@return boolean did_create whether or not it did create a new pane
local create_second_pane = function(current_window, current_pane)
	local current_tab = current_window:active_tab()
	local current_tab_pane_ids = current_tab:panes()
	-- if current pane is the only pane in the tab, create a new horizontal split pane
	if #current_tab_pane_ids == 1 then
		current_window:perform_action(
			wezterm.action.SplitPane({ direction = "Down", size = { Percent = 30 } }),
			current_pane
		)
		return true
	end
	return false
end

--- switch to the alternate pane of the current tab
wezterm.on("alternate-pane", function(current_window, current_pane)
	local did_create = create_second_pane(current_window, current_pane)
	if not did_create then
		current_window:perform_action(wezterm.action.ActivatePaneDirection("Next"), current_pane)
	end
end)

--- toggle zoom of the current pane to reveal the alternate-pane
wezterm.on("alternate-zoom", function(current_window, current_pane)
	local did_create = create_second_pane(current_window, current_pane)
	if not did_create then
		-- if two panes exist already, get the alternate pane (currently *not* selected pane)
		current_window:perform_action(wezterm.action.TogglePaneZoomState, current_pane)
	else
		current_pane:activate()
	end
end)

local process_icons = {
	["nvim"] = wezterm.nerdfonts.custom_v_lang,
	["node"] = wezterm.nerdfonts.dev_nodejs_small,
	["zsh"] = wezterm.nerdfonts.cod_terminal,
	["git"] = wezterm.nerdfonts.dev_git,
	["python"] = wezterm.nerdfonts.dev_python,
}

local get_last_segment = function(str)
	return str:gsub("(.*[/\\])(.*)", "%2")
end

wezterm.on("format-tab-title", function(tab)
	local active_pane = tab.active_pane
	-- remove trailing slash
	local current_dir = active_pane.current_working_dir.file_path:sub(1, -2)
	-- only set the title manually if the directory is available
	if current_dir ~= nil then
		local process = get_last_segment(active_pane.foreground_process_name):lower()
		local dir = get_last_segment(current_dir)
		return { {
			Text = ("%s %s"):format(process_icons[process] or ("%s :"):format(process), dir),
		} }
	end
end)

return {
	-- don't display ugly bar at the top
	window_decorations = "RESIZE",
	window_padding = {
		left = 5,
		right = 5,
		top = 5,
		bottom = 5,
	},
	window_frame = {
		font_size = 16,
		active_titlebar_bg = "#1a1b26",
	},
	inactive_pane_hsb = {
		saturation = 0.4,
		brightness = 0.5,
	},
	keys = {
		-- go to alternate pane
		{
			key = "k",
			mods = "CMD",
			action = wezterm.action.EmitEvent("alternate-pane"),
		},
		-- show or hide alternate pane with cmd + h
		{
			key = "h",
			mods = "CMD",
			action = wezterm.action.EmitEvent("alternate-zoom"),
		},
	},
	font = wezterm.font_with_fallback({
		-- Main font
		"Fira Code",
		-- Fallback to Nerd Font symbols if glyph is not available
		"Symbols Nerd Font",
	}),
	font_size = 18,
	color_scheme = "Tokyo Night",
	colors = {
		tab_bar = {
			active_tab = {
				bg_color = "#1a1b26",
				fg_color = "#fefefe",
			},
			inactive_tab = {
				bg_color = "#1a1b26",
				fg_color = "#808080",
			},
			new_tab = {
				bg_color = "#1a1b26",
				fg_color = "#fefefe",
			},
			inactive_tab_edge = "#1a1b26",
		},
	},
}
