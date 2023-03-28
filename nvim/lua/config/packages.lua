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
		-- use to disable tsserver in vue projects, so that volar can takeover
		-- replace with folke neoconf
		require("config._exrc"),
	}),

	_load.onInsertEnter({
		-- show colors next to color values
		"norcalli/nvim-colorizer.lua",
		-- treesitter context shows current block at the very top
		"nvim-treesitter/nvim-treesitter-context",
		-- add closing bracket automatically, can be stepped through with closing bracket
		"windwp/nvim-autopairs",
		-- comment plugin by tpope. Toggle mapped to <leader>c
		require("config._commentary"),
		require("config._cmp")
	}),
	_load.lazily({
		-- *********** Triggered by Keys *************
		-- telescope fuzzy finder <space> ff to FindFiles and <space> fg to LiveGrep
		require("config._telescope"),
		-- Trouble: better quickfixlists
		require("config._trouble"),
		-- file tree
		require("config._neotree"),
	}),
	_load.onBufferLoad({
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
		-- git plugin by tpope
		{
			"tpope/vim-fugitive",
			init = function()
				vim.opt.diffopt = vim.opt.diffopt + "vertical"
			end,
		},
		-- Treesitter
		require("config._treesitter"),
	}),
	_load.onIdle({
		-- make tpopes plugins dot repeatable
		"tpope/vim-repeat",
		-- for surrounding selected code, mapped to shift-S
		-- svelte specific expansions defined in _surround
		require("config._surround"),
		-- highlight unique letters on f press
		require("config._eyeliner"),
		-- Noice, manage notifications and get fancy command prompt and hover info
		require("config._noice"),
	})
})
