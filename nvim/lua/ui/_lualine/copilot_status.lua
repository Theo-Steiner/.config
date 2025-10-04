local utils = require("lualine.utils.utils")

return {
	"copilot",
	color = {
		gui = "bold",
		fg = utils.extract_color_from_hllist("fg", { "Special", "Boolean", "Constant" }, "#000000"),
	},
	fmt = function()
		local is_copilot_enabled = require("sidekick.status").get()
		return is_copilot_enabled and "" or ""
	end,
	on_click = function()
		if require("sidekick.status").get() then
			for _, client in pairs(vim.lsp.get_clients(
				{ name = "copilot" }
			)) do
				vim.lsp.buf_detach_client(0, client.id)
			end
			return
		end
		for _, client in pairs(vim.lsp.get_clients({
			name = "copilot",
		})) do
			vim.lsp.buf_attach_client(0, client.id)
		end
	end,
}
