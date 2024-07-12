return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local custom_auto = require("lualine.themes.tokyonight")
		-- Change the background of lualine_c section to NONE for all modes
		custom_auto.normal.c.bg = "None"
		-- make section c font bold
		custom_auto.normal.c.gui = "bold"

		require("lualine").setup({
			options = {
				theme = custom_auto,
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				globalstatus = true,
			},
			sections = {
				lualine_c = {},
				lualine_x = {
					{
						"filetype",
						icon_only = true,
						padding = 0,
						separator = "",
					},
					require("ui._lualine.filename"),
				},
				lualine_y = {
					require("ui._lualine.formatting_status"),
					require("ui._lualine.copilot_status"),
				},
			},
		})
	end,
}
