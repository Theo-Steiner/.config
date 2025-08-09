local ascii_art = function()
	return table.concat({
		[[  __     __                              __                 ]],
		[[ /\ \__ /\ \___     ___    ___   __  __ /\_\    ___ ___     ]],
		[[/\`_  _\\ \  _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\   ]],
		[[\/_/\ \/ \ \ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \  ]],
		[[   \ \_\  \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\ ]],
		[[    \/_/   \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/ ]],
	}, "\n")
end

-- hijack when opening a directory
vim.cmd [[
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) |
        \ execute 'cd '.argv()[0] | execute ':lua Snacks.dashboard()' | endif
    ]]

return {
	"folke/snacks.nvim",
	priority = 1000,
	opts = {
		-- files over 1.5MB will be loaded with special settings to improve startup time
		bigfile = {
			enable = true,
			setup = function(ctx)
				vim.g.disable_autoformat = true
				vim.schedule(function()
					vim.bo[ctx.buf].syntax = ctx.ft
				end)
			end
		},
		-- prettier notifications
		notifier = { enabled = true },
		-- skip loading plugins when writing to a not yet existing file
		quickfile = { enabled = true },
		-- auto show lsp references
		words = { enabled = true },
		-- render image previews in the buffer
		image = { enabled = true },
		dashboard = {
			preset = {
				header = ascii_art(),
				keys = {
					{ icon = " ", key = "␣ff", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "␣fg", desc = "Find Grep", action = ":lua Snacks.dashboard.pick('live_grep')" },
					{ icon = "󰒲 ", key = "l", desc = "lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
					{ icon = " ", key = "q", desc = "quit", action = ":qa" },
				},
			},
			sections = {
				{ section = "header" },
				function()
					local lazy_stats = M.lazy_stats and M.lazy_stats.startuptime > 0 and M
					    .lazy_stats or
					    require("lazy.stats").stats()
					return {
						align = "center",
						title = {
							('      just booted in %.2fms, can your editor do that?      \n')
							    :format(
								    lazy_stats.times
								    ['LazyDone']
							    ),
							hl = 'special'
						},
					}
				end,
				{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
			}
		}
	}
}
