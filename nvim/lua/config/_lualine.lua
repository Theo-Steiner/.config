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

		-- a utility to trim the path if it is longer than 45 characters
		local format_path = function(str)
			if string.len(str) < 60 then
				return str
			end
			local s = {}
			for i in string.gmatch(str, "([^/]+)") do
				table.insert(s, i)
			end
			local res = ""
			for i = 1, #s do
				if i < 5 then
					res = "/" .. s[#s + 1 - i] .. res
				else
					return "..." .. res
				end
			end
			return "..." .. res
		end

		local utils = require("lualine.utils.utils")
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
					{
						"filename",
						color = {
							gui = "bold",
							fg = utils.extract_color_from_hllist("fg", { "Special", "Boolean", "Constant" }, "#000000"),
						},
						path = 1, -- 1: relative path
						fmt = format_path,
					},
				},
				lualine_y = {
					{
						"formatting",
						color = {
							gui = "bold",
							fg = utils.extract_color_from_hllist("fg", { "Special", "Boolean", "Constant" }, "#000000"),
						},
						fmt = function()
							return vim.g.AutoFormattingEnabled and "" or ""
						end,
					},
				},
			},
		})
	end,
}
