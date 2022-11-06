-- ****************************************
-- *************** Packages ***************
-- ****************************************

vim.cmd([[packadd packer.nvim]])

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local _ = ensure_packer()

return require("packer").startup(function()
	-- Packer manages itself
	use("wbthomason/packer.nvim")

	-- highlight unique letters on f press
	use {
		'jinh0/eyeliner.nvim',
		config = function()
			require 'eyeliner'.setup {
				highlight_on_key = true
			}
		end
	}

	-- Language server setup with zero config
	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/nvim-lsp-installer" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})

	-- allows non-lsp processes (prettier, eslint) to run lsp-like
	use("jose-elias-alvarez/null-ls.nvim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("config._treesitter")
		end,
	})

	-- treesitter context shows current block at the very top
	use 'nvim-treesitter/nvim-treesitter-context'

	-- Dependencies for modern nvim plugins (for telescope, neo-tree, lualine etc)
	use("kyazdani42/nvim-web-devicons")
	use("nvim-lua/popup.nvim")
	use("MunifTanjim/nui.nvim")
	use("sharkdp/fd")

	use("nvim-lua/plenary.nvim")

	-- Trouble: better quickfixlists
	use({
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({
				action_keys = { open_tab = "<c-q>" },
			})
		end,
	})

	-- telescope fuzzy finder <space> ff to FindFiles and <space> fg to LiveGrep
	use({
		"nvim-telescope/telescope.nvim",
		requires = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
		config = function()
			require("config._telescope")
		end,
	})

	use({ 'folke/tokyonight.nvim', config = function()
		require("config._tokyonight")
	end })

	-- use({
	-- 	"~/dev/warped.nvim",
	-- 	requires = { "tjdevries/colorbuddy.nvim" },
	-- 	config = function()
	-- 		require("config._warped")
	-- 	end,
	-- })

	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		config = function()
			require("config._neotree")
		end,
	})

	-- surround selected code, mapped to shift-S
	use({
		"tpope/vim-surround",
		config = function()
			require("config._surround")
		end,
	})

	use {
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	}

	-- legendary git plugin
	use("tpope/vim-fugitive")

	-- comment plugin... lol @tpope
	use("tpope/vim-commentary")

	-- get correct commentstring before commenting (configured in _treesitter.lua)
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- Git signs
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})

	-- jump through files
	use({
		"ThePrimeagen/harpoon",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config._harpoon")
		end,
	})

	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	-- statusline
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("config._lualine")
		end,
	})
end)
