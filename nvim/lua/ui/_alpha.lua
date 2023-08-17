-- hide status bar when starting up from alpha
Set.laststatus = 0

-- hijack when opening a directory
vim.cmd [[
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) |
        \ execute 'cd '.argv()[0] | execute 'lua require("alpha").start()' | endif
    ]]


return {
	'goolord/alpha-nvim',
	event = 'VimEnter',
	keys = {
		-- open alpha (but close neotree first to prevent issues)
		{ "<leader>a", ":Neotree close<cr>:Alpha<cr>", silent = true }
	},
	config = function()
		local theovim_textart = {
			[[  __     __                              __]],
			[[ /\ \__ /\ \___     ___    ___   __  __ /\_\    ___ ___]],
			[[/\`_  _\\ \  _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\]],
			[[\/_/\ \/ \ \ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \]],
			[[   \ \_\  \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
			[[    \/_/   \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
			[[                                                           ]],
			('      just booted in %.2fms, can your editor do that?      '):format(
				require("lazy").stats().times
				['LazyDone']
			),
		}
		local mru = require("alpha.themes.theta").mru
		local dashboard = require("alpha.themes.dashboard")
		local header = {
			type = "text",
			val = theovim_textart,
			opts = {
				position = "center",
				hl = "Type",
				-- wrap = "overflow";
			},
		}

		local section_mru = {
			type = "group",
			val = {
				{
					type = "text",
					val = "Recent",
					opts = {
						hl = "SpecialComment",
						shrink_margin = false,
						position = "center",
					},
				},
				{ type = "padding", val = 1 },
				{
					type = "group",
					val = function()
						return { mru(0, vim.fn.getcwd()) }
					end,
					opts = { shrink_margin = false },
				},
			},
		}

		local buttons = {
			type = "group",
			val = {
				{
					type = "text",
					val = "Actions",
					opts = {
						hl = "SpecialComment",
						position = "center"
					}
				},
				{ type = "padding", val = 1 },
				dashboard.button("l", "  Lazy.nvim", "<cmd>Lazy<CR>"),
				dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
			},
			position = "center",
		}

		local config = {
			layout = {
				{ type = "padding", val = 2 },
				header,
				{ type = "padding", val = 2 },
				section_mru,
				{ type = "padding", val = 2 },
				buttons,
			},
			opts = {
				margin = 5,
			},
		}
		require('alpha').setup(config)
	end,
	dependencies = { 'nvim-tree/nvim-web-devicons', "nvim-lua/plenary.nvim" }
}
