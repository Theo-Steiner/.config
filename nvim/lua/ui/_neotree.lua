return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		-- open file tree with "-"
		{ "-", ":Neotree reveal<cr>", silent = true },
	},
	cmd = "Neotree",
	branch = "v3.x",
	config = function()
		local renderer = require("neo-tree.ui.renderer")
		local cmds = require("neo-tree.sources.filesystem.commands")
		--- @param state table tree state of neotree
		--- @param offset -1 | 1 move cursor up or down
		local move_cursor = function(state, offset)
			renderer.focus_node(state, nil, true, offset)
		end
		require("neo-tree").setup({
			event_handlers = {
				{
					event = "neo_tree_buffer_leave",
					handler = function()
						local state = require("neo-tree.sources.manager").get_state("filesystem")
						local fs = require("neo-tree.sources.filesystem")
						fs.reset_search(state, false)
					end,
				},
			},
			close_if_last_window = true,
			popup_border_style = "rounded",
			window = {
				position = "float",
				mappings = {
					["/"] = "none",
					["<C-f>"] = function(state)
						if state.search_pattern ~= nil then
							cmds.clear_filter(state)
						end
						cmds.filter_as_you_type(state)
						-- set up and down for insert mode while searching
						vim.keymap.set("i", "<C-n>", function()
							move_cursor(state, 1)
						end, { buffer = true })
						vim.keymap.set("i", "<C-p>", function()
							move_cursor(state, -1)
						end, { buffer = true })
					end,
					["<C-n>"] = function(state)
						move_cursor(state, 1)
					end,
					["<C-p>"] = function(state)
						move_cursor(state, -1)
					end,
				},
			},
			git_status_async = true,
			default_component_configs = {
				file_size = {
					enabled = false,
				},
			},
			filesystem = {
				filtered_items = {
					hide_by_name = {
						".DS_Store",
						"thumbs.db",
						"node_modules",
					},
				},
				use_libuv_file_watcher = true,
				window = {
					fuzzy_finder_mappings = {
						["<C-n>"] = function(state)
							move_cursor(state, 1)
						end,
						["<C-p>"] = function(state)
							move_cursor(state, -1)
						end,
					},
					mappings = {
						["<C-n>"] = function(state)
							move_cursor(state, 1)
						end,
						["<C-p>"] = function(state)
							move_cursor(state, -1)
						end,
					},
				},
			},
		})
	end,
}
