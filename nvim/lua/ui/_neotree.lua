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
	branch = "v3.x",
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			popup_border_style = "rounded",
			window = {
				width = 35,
				mappings = {
					["/"] = "noop",
				},
			},
			git_status_async = true,
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
