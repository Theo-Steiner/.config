-- ****************************************
-- ********** BASIC VIM SETTINGS **********
-- ****************************************

-- because languages
Set.encoding = "UTF-8"

Set.tabstop = 2

-- scroll screen 8 lines before the cursor hits the edge vertically and 5 horizontally
Set.scrolloff = 8
Set.sidescrolloff = 5

-- activate linenumbers
Set.number = true

-- make linenumbers relative to cursor position
Set.relativenumber = true

-- a new fold is made with visual line mode and then <za>
Set.foldlevel = 99
Set.foldmethod = "expr"
Set.foldexpr = "nvim_treesitter#foldexpr()"

-- Remember folds for buffers
vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
	pattern = { "*.*" },
	callback = function()
		vim.cmd([[mkview]])
	end,
})
-- Load folds on buf-enter
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = { "*.*" },
	callback = function()
		vim.cmd([[silent! loadview]])
	end,
})

-- paste over selected content no longer replaces clipboard
-- && set clipboard to mac/windows system clipboard
Map("v", "p", '"_dP')
Set.cb = "unnamed"

-- hides 'No write since last change (add ! to override)' error
Set.hidden = true

-- fixes broken width of neovim/neovim/issues/11330
vim.api.nvim_create_autocmd({ "VimEnter" }, {
	callback = function()
		local pid, WINCH = vim.fn.getpid(), vim.loop.constants.SIGWINCH
		vim.defer_fn(function() vim.loop.kill(pid, WINCH) end, 20)
	end
})
