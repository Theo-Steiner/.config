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
					colors.border = "#8be9fd"
					colors.diff.delete = "#ff0000"
					colors.bg_highlight = "NONE"
				end,
				on_highlights = function(hl, c)
					hl.NormalFloat = {
						fg = c.fg_dark,
						bg = c.bg_highlight,
					}
					hl.FloatBorder = {
						fg = c.border,
						bg = c.bg_highlight,
					}
					hl.CursorLine = {
						color = hl.CursorLine.color,
						bold = true
					}
				end
			})
			vim.cmd [[colorscheme tokyonight]]
		end
	}
}
