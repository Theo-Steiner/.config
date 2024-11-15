return {
	"folke/snacks.nvim",
	priority = 1000,
	opts = {
		-- files over 1.5MB will be loaded with special settings to improve startup time
		bigfile = {
			enable = true,
			setup = function(ctx)
				vim.g.disable_autoformat = true
				vim.schedule(function()
					vim.bo[ctx.buf].syntax = ctx.ft
				end)
			end
		},
		-- prettier notifications
		notifier = { enabled = true },
		-- skip loading plugins when writing to a not yet existing file
		quickfile = { enabled = true },
		-- auto show lsp references
		words = { enabled = true },
	}
}
