return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope-live-grep-args.nvim" },
	keys = {
		-- use <leader> ff to open fuzzy finder preview to find file in project
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", silent = true },
		-- use <leader> fg to open fuzzy finder preview to live-grep in project
		{ "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", silent = true },
		-- use <leader> fc to search for merge conflicts
		{ "<leader>fc", "<cmd>Telescope grep_string search=<<<<<<<<cr>", silent = true },
	},
	config = function()
		local telescope = require("telescope")
		local trouble = require("trouble.providers.telescope")
		local config = {
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

		telescope.setup(config)
	end,
}
