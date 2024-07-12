local utils = require("lualine.utils.utils")

-- @return is_copilot_enabled: boolean
local get_copilot_status = function()
	return vim.g.loaded_copilot == 1 and vim.fn["copilot#Enabled"]() == 1
end

return {
	"copilot",
	color = {
		gui = "bold",
		fg = utils.extract_color_from_hllist("fg", { "Special", "Boolean", "Constant" }, "#000000"),
	},
	fmt = function()
		local is_copilot_enabled = get_copilot_status()
		return is_copilot_enabled and "" or ""
	end,
	on_click = function()
		if get_copilot_status() then
			vim.b.copilot_enabled = 0
		else
			vim.b.copilot_enabled = nil
		end
	end,
}
