local has_telescope, telescope = pcall(require, 'telescope')
if not has_telescope then
	error 'This extension requires telescope.nvim (https://github.com/nvim-telescope/telescope.nvim)'
end

local builtin = require 'telescope.builtin'

local M = {
	config = {},
}

M.toggle = function(toggle_prop)
	return function(opts, callback)
		opts['prompt_title'] = 'Find Files'
		opts[toggle_prop] = not opts[toggle_prop]
		if opts[toggle_prop] then
			opts['prompt_title'] = 'Find Files (' .. toggle_prop .. ')'
		end
		callback(opts)
	end
end

M.toggle_args = function(params)
	return function(opts, callback)
		if not opts['additional_args'] then
			opts['additional_args'] = params
			opts['prompt_title'] = 'Live Grep (hidden)'
		else
			opts['additional_args'] = nil
			opts['prompt_title'] = 'Live Grep'
		end
		callback(opts)
	end
end

M.add_action = function(fn, action)
	local query = nil
	local function launch(opts)
		opts = opts or {}

		opts.attach_mappings = function(new_bufnr, map)
			-- restore previous query if exists
			if query then
				local picker = require('telescope.actions.state').get_current_picker(new_bufnr)
				picker:set_prompt(query)
				-- delete saved query
				query = nil
			end
			map({ "n", "i" }, '<C-^>', function(current_bufnr)
				local picker = require('telescope.actions.state').get_current_picker(current_bufnr)
				-- save current query
				query = picker:_get_prompt()
				action(opts, launch)
			end)
			return true
		end

		fn(vim.tbl_extend('force', opts, { default_text = opts.prompt_value }))
	end

	return launch
end

M.find_files = M.add_action(builtin.find_files, M.toggle("no_ignore"))
M.live_grep = M.add_action(builtin.live_grep,
	M.toggle_args({ '--no-ignore', "-g", "!package-lock.json", "-g", "!**/.git/*", }))

return telescope.register_extension {
	setup = function(opts)
		M.config = vim.tbl_deep_extend('force', M.config, opts)
	end,
	exports = M,
}
