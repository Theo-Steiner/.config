return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter",
	},
	keys = {
		-- use <leader> ff to open fuzzy finder preview to find file in project
		{ "<leader>ff", function()
			require('telescope').extensions.togglescope.find_files()
		end, silent = true },
		-- use <leader> fg to open fuzzy finder preview to live-grep in project
		{ "<leader>fg",
			function()
				require('telescope').extensions.togglescope.live_grep()
			end
			, silent = true },
		-- use <leader> fc to search for merge conflicts
		{ "<leader>fc", "<cmd>Telescope grep_string search=<<<<<<<<cr>", silent = true },
	},
	config = function()
		local telescope = require("telescope")
		local trouble = require("trouble.providers.telescope")
		telescope.load_extension("togglescope")
		local config = {
			defaults = {
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				file_ignore_patterns = { "^.git/" },
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
		telescope.setup(config)
	end,
}
