return {
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				on_highlights = function(hl, c)
					hl.NeoTreeFloatBorder = {
						fg = c.black,
					}
					hl.FloatBorder = {
						fg = c.none,
						bg = c.none,
					}
				end
			})
			vim.cmd [[colorscheme tokyonight-night]]
		end
	}
}
