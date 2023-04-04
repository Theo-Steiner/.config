return {
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				transparent = true,
				styles = { sidebars = "transparent" },
				dim_inactive = true,
				on_colors = function(colors)
					colors.comment = "#848cb1"
					colors.fg_gutter = "#56608d"
					colors.border = "NONE"
					colors.diff.delete = "#ff0000"
					colors.none = "NONE"
					colors.bg_highlight = colors.none
				end,
				on_highlights = function(hl, c)
					hl.FloatBorder = {
						fg = c.none,
						bg = c.none,
					}
					hl.CursorLine = {
						bold = true
					}
				end
			})
			vim.cmd [[colorscheme tokyonight]]
		end
	}
}
