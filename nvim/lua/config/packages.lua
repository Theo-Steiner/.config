-- bootstrap and setup utils
local _load = require("config._lazy")
return require("lazy").setup({
	-- ****************************************
	-- *************** Packages ***************
	-- ****************************************
	_load.eagerly({
		-- colorscheme
		require("config._tokyonight"),
		-- startup screen
		require("config._alpha"),
	}),

	_load.on_insert_enter({
		-- show colors next to color values
		"norcalli/nvim-colorizer.lua",
		-- treesitter context shows current block at the very top
		"nvim-treesitter/nvim-treesitter-context",
		-- add closing bracket automatically, can be stepped through with closing bracket
		"windwp/nvim-autopairs",
		-- lsp completions
		require("config._cmp"),
	}),
	_load.lazily({
		-- *********** Triggered by Keys *************
		-- telescope fuzzy finder <space> ff to FindFiles and <space> fg to LiveGrep
		require("config._telescope"),
		-- Trouble: better quickfixlists
		require("config._trouble"),
		-- file tree
		require("config._neotree"),
		-- long running terminal that can easily be toggled
		require("config._toggleterm"),
		-- *********** Triggered by CMDs *************
		-- comment plugin by tpope.
		require("config._commentary"),
	}),
	_load.on_buf_read({
		require("config._lsp"),
		-- allows non-lsp processes (prettier, eslint) to run lsp-like
		require("config._null-ls"),
		-- Git signs
		"lewis6991/gitsigns.nvim",
		-- Primeagen plugin to jump through files
		require("config._harpoon"),
		-- heuristically set buffer options
		"tpope/vim-sleuth",
		-- statusline
		require("config._lualine"),
		-- make tpopes plugins dot repeatable
		"tpope/vim-repeat",
		-- git plugin by tpope
		require("config._fugitive"),
		-- Treesitter
		require("config._treesitter"),
		-- highlight unique letters on f press
		require("config._eyeliner"),
		-- for surrounding selected code, mapped to shift-S
		-- svelte specific expansions defined in _surround
		require("config._surround"),
	}),
	_load.on_idle({
		-- Noice, manage notifications and get fancy command prompt and hover info
		require("config._noice"),
	})
})
