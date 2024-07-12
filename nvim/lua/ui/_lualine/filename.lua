local utils = require("lualine.utils.utils")

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

return {
	"filename",
	color = {
		gui = "bold",
		fg = utils.extract_color_from_hllist("fg", { "Special", "Boolean", "Constant" }, "#000000"),
	},
	path = 1, -- 1: relative path
	fmt = format_path,
	on_click = function()
		local current_path = vim.api.nvim_buf_get_name(0)
		print(current_path)
		vim.fn.setreg("+", current_path)
	end,
}
