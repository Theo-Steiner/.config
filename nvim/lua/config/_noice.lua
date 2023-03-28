return {
	"folke/noice.nvim",
	dependencies = {
		"nvim-lua/popup.nvim",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ ':' }
	},
	config = function()
		require("noice").setup({
			lsp = {
				override = {
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
