-- ****************************************
-- *************** Bootstrap **************
-- ****************************************
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- ****************************************
-- *************** Packages ***************
-- ****************************************
return require("lazy").setup({
	-- colorscheme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("config._tokyonight")
		end
	},
	-- file tree
	{
		lazy = false,
		priority = 1000,
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		init = function()
			require("config._neotree")
		end,
	},

	-- highlight unique letters on f press
	{
		"jinh0/eyeliner.nvim",
		config = function()
			require "eyeliner".setup {
				highlight_on_key = true
			}
		end
	},

	-- use to disable tsserver in vue projects, so that volar can takeover
	{
		"MunifTanjim/exrc.nvim",
		config = function()
			vim.o.exrc = false
			require("exrc").setup({
				files = {
					".nvimrc.lua",
					".nvimrc",
					".exrc.lua",
					".exrc",
				},
			})
		end,
	},

	-- Language server setup with zero config
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			-- LSP Support
			"neovim/nvim-lspconfig",
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
			-- Autocompletion
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",

			-- Snippets
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
	},

	-- allows non-lsp processes (prettier, eslint) to run lsp-like
	"jose-elias-alvarez/null-ls.nvim",

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("config._treesitter")
		end,
	},

	-- treesitter context shows current block at the very top
	"nvim-treesitter/nvim-treesitter-context",

	-- Dependencies for modern nvim plugins (for telescope, neo-tree, lualine etc)
	"kyazdani42/nvim-web-devicons",
	"nvim-lua/popup.nvim",
	"MunifTanjim/nui.nvim",
	"sharkdp/fd",

	"nvim-lua/plenary.nvim",

	-- Trouble: better quickfixlists
	{
		"folke/trouble.nvim",
		config = function()
			require("config._tokyonight")
		end,
	},

	{
		"folke/noice.nvim",
		config = function()
			require("config._noice")
		end,
		requires = {
			"MunifTanjim/nui.nvim",
		}
	},


	-- telescope fuzzy finder <space> ff to FindFiles and <space> fg to LiveGrep
	{
		"nvim-telescope/telescope.nvim",
		requires = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope-live-grep-args.nvim" },
		config = function()
			require("config._telescope")
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	},

	-- ### TPOPE SECTION START ###
	-- how about surrounding selected code? mapped to shift-S
	-- svelte specifics defined in _surround
	{
		"tpope/vim-surround",
		config = function()
			require("config._surround")
		end,
	},

	-- git plugin by tpope
	{
		"tpope/vim-fugitive",
		config = function()
			vim.opt.diffopt = vim.opt.diffopt + "vertical"
		end,
	},

	-- comment plugin by tpope. Toggle mapped to <leader>c
	"tpope/vim-commentary",

	-- make tpopes plugins dot repeatable
	"tpope/vim-repeat",

	-- I mean just look at this man go
	"tpope/vim-sleuth",
	-- ### TPOPE SECTION END ###

	-- get correct commentstring before commenting (configured in _treesitter.lua)
	"JoosepAlviste/nvim-ts-context-commentstring",

	-- Git signs
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},

	-- jump through files
	{
		"ThePrimeagen/harpoon",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config._harpoon")
		end,
	},

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("config._lualine")
		end,
	},
})
