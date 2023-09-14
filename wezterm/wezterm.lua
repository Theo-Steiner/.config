local wezterm = require('wezterm')
local io = require('io')
local os = require('os')


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
			wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }),
			current_pane
		)
		return true
	end
	return false
end

wezterm.on('vim-mode', function(current_window, current_pane)
	-- retrieve the last 300 lines of terminal output
	local viewport_text = current_pane:get_lines_as_text(300)

	-- create a temporary file to pass to vim
	local tmpfile = os.tmpname()
	local f, err = io.open(tmpfile, 'w+')
	if f == nil then
		print(err)
	else
		f:write(viewport_text)
		f:flush()
		f:close()
	end

	-- Open a new window running vim and tell it to open the file
	current_window:perform_action(
		wezterm.action.SpawnCommandInNewWindow {
			args = {
				-- path to executable
				'/opt/homebrew/bin/nvim',
				-- temporary file name
				tmpfile,
				-- set cursor to last line
				'+',
				-- set filetype to sh for some best effor highlighting
				'+set filetype=sh'
			},
		},
		current_pane
	)

	-- remove tmpfile after giving nvim time to read it
	wezterm.sleep_ms(1000)
	os.remove(tmpfile)
end)

--- switch to the alternate pane of the current tab
wezterm.on('alternate-pane', function(current_window, current_pane)
	local did_create = create_second_pane(current_window, current_pane)
	if not did_create then
		current_window:perform_action(
			wezterm.action.ActivatePaneDirection('Next'),
			current_pane
		)
	end
end)

--- toggle zoom of the current pane to reveal the alternate-pane
wezterm.on('alternate-zoom', function(current_window, current_pane)
	local did_create = create_second_pane(current_window, current_pane)
	if not did_create then
		-- if two panes exist already, get the alternate pane (currently *not* selected pane)
		current_window:perform_action(
			wezterm.action.TogglePaneZoomState,
			current_pane
		)
	else
		current_pane:activate()
	end
end)

local process_icons = {
	['nvim'] = wezterm.nerdfonts.custom_v_lang,
	['node'] = wezterm.nerdfonts.dev_nodejs_small,
	['zsh'] = wezterm.nerdfonts.cod_terminal,
	['git'] = wezterm.nerdfonts.dev_git,
}

local function get_current_working_dir(tab)
	local current_dir = tab.active_pane.current_working_dir
	return string.gsub(current_dir, '(.*[/\\])(.*)', '%2')
end

local function get_process(tab)
	local process_name = string.gsub(tab.active_pane.foreground_process_name, '(.*[/\\])(.*)', '%2')
	return string.format('%s  %s', process_icons[process_name] or process_name, process_name)
end

wezterm.on(
	'format-tab-title',
	function(tab)
		local title = string.format('%s: %s  ', get_process(tab), get_current_working_dir(tab))
		return {
			{ Text = title },
		}
	end
)

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
	inactive_pane_hsb = {
		saturation = 1,
		brightness = .3,
	},
	keys = {
		-- bind wezterm copy mode to inspector hotkey
		{
			key = 'i',
			mods = 'CMD|ALT',
			action = wezterm.action.EmitEvent('vim-mode'),
		},
		-- go to alternate pane
		{
			key = 'k',
			mods = 'CMD',
			action = wezterm.action.EmitEvent('alternate-pane'),
		},
		-- show or hide alternate pane with cmd + h
		{
			key = 'h',
			mods = 'CMD',
			action = wezterm.action.EmitEvent('alternate-zoom'),
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
