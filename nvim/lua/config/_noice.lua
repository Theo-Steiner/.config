return {
	"folke/noice.nvim",
	dependencies = {
		"nvim-lua/popup.nvim",
		"MunifTanjim/nui.nvim",
		"VonHeikemen/lsp-zero.nvim",
	},
	config = function()
		require("noice").setup({
			lsp = {
				-- override markdown rendering so that **cmp**
				-- and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			views = {
				hover = {
					position = {
						row = 2,
						col = 0
					},
					border = { style = "rounded" }
				},
				mini = {
					border = {
						style = "rounded",
					},
					position = {
						row = -2,
					},
					win_options = {
						winblend = 0,
						winhighlight = {
							Normal = "NoiceCmdlinePopup",
							FloatBorder = "NoiceCmdlinePopupBorder",
						}
					}
				},
				split = {
					win_options = {
						winhighlight = {
							Normal = "BG_HIGHLIGHT"
						},
					}
				}
			},
		})
	end,
}
