return {
	'akinsho/toggleterm.nvim',
	keys = {
		{ "<C-s>", ":ToggleTerm<CR>", silent = true },
		-- quit nvim terminal
		{ mode = "t", "<C-s>", "<C-\\><C-n>:ToggleTerm<CR>", silent = true },
		{ mode = "t", "<C-w>", "<C-\\><C-n><C-w>", silent = true },
		{ mode = "t", "jk", "<C-\\><C-n>", silent = true }
	},
	config = function()
		require('toggleterm').setup({ persist_mode = false })
	end,
}
