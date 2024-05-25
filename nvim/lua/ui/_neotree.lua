return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		-- open file tree witvh <leader> p
		{ "<leader>pv", ":Neotree reveal toggle<cr>", silent = true },
	},
	cmd = "Neotree",
	branch = "v3.x",
	config = function()
		require("neo-tree").setup({
			event_handlers = {
				{
					event = "neo_tree_buffer_leave",
					handler = function()
						local state = require("neo-tree.sources.manager").get_state("filesystem")
						local fs = require("neo-tree.sources.filesystem")
						fs.reset_search(state, false)
					end
				}
			},
			close_if_last_window = true,
			popup_border_style = "rounded",
			window = {
				position = "float",
				mappings = {
					["/"] = function(state)
						if state.search_pattern ~= nil then
							require("neo-tree.sources.filesystem.commands").clear_filter(state)
						end
						require("neo-tree.sources.filesystem.commands").filter_as_you_type(state)
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
				hijack_netrw_behavior = "disabled",
				use_libuv_file_watcher = true,
			},
		})
	end,
}
