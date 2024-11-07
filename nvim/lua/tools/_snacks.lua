return {
	"folke/snacks.nvim",
	priority = 1000,
	opts = {
		bigfile = {
			enable = true,
			setup = function(ctx)
				vim.g.disable_autoformat = true
				vim.schedule(function()
					vim.bo[ctx.buf].syntax = ctx.ft
				end)
			end
		}
	}
}
