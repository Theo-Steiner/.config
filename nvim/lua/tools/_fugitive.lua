return {
	"tpope/vim-fugitive",
	cmd = {
		"G", "Git", "Gread", "Gwrite", "Gdiff"
	},
	keys = {
		-- use <leader>gc to pretype commit
		{
			"<leader>gc",
			":G commit -m \"",
		},
		-- use <leader>g to open fugitive
		{
			"<leader>gr",
			":Gread<cr>",
			silent = true,
		},
		-- use <leader>g to open fugitive
		{
			"<leader>gw",
			":Gwrite<cr>",
			silent = true,
		},
	},
	init = function()
		-- make default diff view vertical
		vim.opt.diffopt = vim.opt.diffopt + "vertical"
	end,
}
