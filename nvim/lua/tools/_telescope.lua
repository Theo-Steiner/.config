local getVisualSelection = function()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		{
			"Theo-Steiner/togglescope",
			-- uncomment to use from ~projects/togglescope
			-- dev = true
		},
	},
	keys = {
		-- use <leader> ff to open fuzzy finder preview to find file in project
		{
			"<leader>ff",
			function()
				require("telescope").extensions.togglescope.find_files({ default_text = getVisualSelection() })
			end,
			silent = true,
			mode = { "n", "v" },
		},
		-- use <leader> fg to open fuzzy finder preview to live-grep in project
		{
			"<leader>fg",
			function()
				require("telescope").extensions.togglescope.live_grep({
					additional_args = {
						"-g",
						"!*-lock.*",
					},
					default_text = getVisualSelection(),
				})
			end,
			silent = true,
			mode = { "n", "v" },
		},
		-- use <leader> fc to search for merge conflicts
		{ "<leader>fc", "<cmd>Telescope grep_string search=<<<<<<<<cr>", silent = true },
		{
			"<leader>fs",
			function()
				require("telescope.builtin").git_status()
			end,
			silent = true,
		},
		-- use <leader> fc to search for merge conflicts
		{
			"<C-g>",
			function()
				require("telescope.builtin").git_branches()
			end,
			silent = true,
		},
	},
	config = function()
		local telescope = require("telescope")
		local trouble = require("trouble.sources.telescope")
		local config = {
			extensions = {
				togglescope = {
					find_files = {
						["<C-^>"] = {
							no_ignore = true,
							hidden = true,
							togglescope_title = "Find Files (hidden)",
						},
					},
					live_grep = {
						["<C-^>"] = {
							additional_args = {
								"--no-ignore",
								"--hidden",
							},
							togglescope_title = "Live Grep (hidden)",
						},
					},
				},
				repo = {
					settings = {
						auto_lcd = false,
					},
					list = {
						search_dirs = {
							"~/dev",
						},
						-- not yet implemented https://github.com/cljoly/telescope-repo.nvim/issues/56 maybe do a PR
						mappings = {
							i = {
								["<CR>"] = function()
									print("hello")
								end,
							},
						},
					},
				},
			},
			defaults = {
				file_ignore_patterns = { "^.git/" },
				mappings = {
					i = {
						["<c-t>"] = trouble.open,
						["<c-f>"] = require("telescope.actions").to_fuzzy_refine,
					},
					n = {
						["<c-t>"] = trouble.open,
						["q"] = require("telescope.actions").close,
					},
				},
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
				borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
			},
		}
		telescope.setup(config)
	end,
}
