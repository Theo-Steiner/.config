require("tokyonight").setup({
	transparent = true,
	styles = { sidebars = "transparent" },
	dim_inactive = true,
	on_colors = function(colors)
		colors.border = "#8be9fd"
		colors.diff.delete = "#ff0000"
		colors.bg_highlight = "NONE"
	end,
	on_highlights = function(hl, _)
		hl.CursorLine = {
			color = hl.CursorLine.color,
			bold = true
		}
	end
})
vim.cmd [[colorscheme tokyonight]]
