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
			presets = { long_message_to_split = true, },
			lsp = {
				progress = { enabled = true },
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = false,
					["vim.lsp.util.stylize_markdown"] = false,
					["cmp.entry.get_documentation"] = false,
				},
			},
		})
	end,
}
