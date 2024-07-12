local utils = require("lualine.utils.utils")

return {
	"formatting",
	color = {
		gui = "bold",
		fg = utils.extract_color_from_hllist("fg", { "Special", "Boolean", "Constant" }, "#000000"),
	},
	fmt = function()
		return vim.g.disable_autoformat and "󰉥" or ""
	end,
	on_click = function()
		vim.cmd("Formatting")
	end,
}
