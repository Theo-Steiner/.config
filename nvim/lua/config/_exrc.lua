return {
	"MunifTanjim/exrc.nvim",
	config = function()
		vim.o.exrc = false
		require("exrc").setup({
			files = {
				".nvimrc.lua",
				".nvimrc",
				".exrc.lua",
				".exrc",
			},
		})
	end,
}
