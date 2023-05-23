return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require('gitsigns').setup({
			on_attach = function()
				local gs = package.loaded.gitsigns
				vim.keymap.set(
					'n', "<C-]>",
					function()
						if vim.wo.diff then return "<C-]>" end
						vim.schedule(function() gs.next_hunk() end)
						return "<Ignore>"
					end, { expr = true })
				vim.keymap.set(
					'n', "<C-[>",
					function()
						if vim.wo.diff then return "<C-[>" end
						vim.schedule(function() gs.prev_hunk() end)
						return "<Ignore>"
					end, { expr = true })
			end
		})
	end
}
