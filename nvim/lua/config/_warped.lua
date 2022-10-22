local mapping = require("warped.default_mapping")
mapping["gruvboxdark"] = require("warped.utils").shallow_copy(mapping.default)
mapping["solarizeddark"] = mapping["gruvboxdark"]
mapping.gruvboxdark.blue = "bright_magenta"
require("warped").setup({
	theme_config = function(Color, colors, Group, groups, styles)
		require("warped.default_theme_config")(Color, colors, Group, groups, styles)
		Group.new("CursorLine", colors.none, colors.none, styles.bold)
		Group.new("Folded", colors.none, colors.none)

		local darker = colors.background:dark(0.01)
		local lighter = colors.background:light()

		-- Telescope prompt
		Group.new("TelescopePromptTitle", colors.black, colors.red)
		Group.new("TelescopePromptBorder", colors.none, lighter)
		Group.new("TelescopePromptNormal", colors.blue, lighter)
		Group.new("TelescopePromptPrefix", colors.red, lighter)

		-- Telescope results
		Group.new("TelescopeResultsTitle", colors.none, darker)
		Group.new("TelescopeResultsBorder", colors.none, lighter)
		Group.new("TelescopeResultsNormal", colors.none, darker)
		-- selected result hl group
		Group.new("TelescopeSelection", colors.black, colors.red)

		-- Telescope preview
		Group.new("TelescopePreviewTitle", colors.none, colors.none)
		Group.new("TelescopePreviewBorder", colors.none, lighter)
		Group.new("TelescopePreviewNormal", colors.none, darker)

		-- TreesitterContext current code block highlighting
		Group.new("TreesitterContext", colors.none, darker, styles.bold)
	end,
	mapping = mapping,
})
