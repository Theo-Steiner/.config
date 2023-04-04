return {
	"tpope/vim-fugitive",
	cmd = {
		"G", "Git", "Gread", "Gwrite", "Gdiff"
	},
	keys = {

	},
	init = function()
		vim.opt.diffopt = vim.opt.diffopt + "vertical"
	end,
}
