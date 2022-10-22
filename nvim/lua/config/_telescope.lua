local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")

local options = {
	defaults = {
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		borderchars = {
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
			" ",
		},
		mappings = {
			i = { ["<c-t>"] = trouble.open_with_trouble },
			n = {
				["<c-t>"] = trouble.open_with_trouble,
				["q"] = require("telescope.actions").close,
			},
		},
	},
}

telescope.setup(options)
