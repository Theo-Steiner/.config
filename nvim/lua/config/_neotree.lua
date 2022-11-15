-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

-- icons for diagnostic errors
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

require("neo-tree").setup({
	close_if_last_window = true,
	popup_border_style = "rounded",
	window = {
		width = 35,
		mappings = {
			["/"] = "noop"
		}
	},
	git_status_async = true,
	filesystem = {
		hijack_netrw_behavior = "open_current",
		filtered_items = {
			hide_by_name = {
				".DS_Store",
				"thumbs.db",
				"node_modules",
			},
		},
		use_libuv_file_watcher = true,
	},
})
