-- bootstrap and setup utils
local load = require("packages._lazy")

return require("lazy").setup({
	-- ****************************************
	-- *************** Packages ***************
	-- ****************************************
	load.eagerly({
		-- a collection of tools that for example improve large file handling
		require("tools._snacks"),
		-- colorscheme
		require("ui._tokyonight"),
	}),
	load.on_insert_enter({
		-- show colors next to color values
		"norcalli/nvim-colorizer.lua",
		-- treesitter context shows current block at the very top
		require("ide._treesitter-context"),
		-- add closing bracket automatically, can be stepped through with closing bracket
		"windwp/nvim-autopairs",
		-- completions
		require("ide._blink"),
	}),
	load.lazily({
		-- *********** Triggered by Keys *************
		-- telescope fuzzy finder <space> ff to FindFiles and <space> fg to LiveGrep
		require("tools._telescope"),
		-- Trouble: better quickfixlists
		require("tools._trouble"),
		-- file tree
		require("ui._neotree"),
		-- plugins and setting to enable debugging
		-- <leader>b to set a breakpoint and <leader>c to continue a debug session
		require("ide.lsp.debugging"),
		require("ide.lsp.debugging.js-dap"),
		require("ide.lsp.debugging.go-dap"),
		-- *********** Triggered by CMDs *************
		-- comment plugin by tpope.
		require("tools._commentary"),
	}),
	load.on_buf_read({
		-- setup lsps
		require("ide.lsp"),
		-- ai tooling
		require("ide._sidekick"),
		-- formatting (check attached formatters with "ConformInfo")
		require("ide._conform"),
		-- linting (check attached formatters with "ConformInfo")
		require("ide._lint"),
		-- Git signs
		require("ide._gitsigns"),
		-- heuristically set buffer options
		"tpope/vim-sleuth",
		-- statusline
		require("ui._lualine"),
		-- make tpopes plugins dot repeatable
		"tpope/vim-repeat",
		-- git plugin by tpope
		require("tools._fugitive"),
		-- Treesitter
		require("ide._treesitter"),
		-- highlight unique letters on f press
		require("ui._eyeliner"),
		-- for surrounding selected code, mapped to shift-S
		-- svelte specific expansions defined in _surround
		require("tools._surround"),
	}),
	load.on_idle({
		-- Noice, manage notifications and get fancy command prompt and hover info
		require("ui._noice"),
		-- Enable lsp operations for file tree
		require("ui._neotree_file_operations"),
	}),
})
