return {
	"tpope/vim-commentary",
	keys = {
		-- <leader> c toggles the current line or current selection to be a comment
		{
			"<leader>c",
			function()
				require('ts_context_commentstring.internal').update_commentstring()
				vim.api.nvim_feedkeys(
					vim.api.nvim_replace_termcodes(":Commentary<CR>", true, false, true),
					"",
					false)
			end,
			silent = true
		}
	}
}
