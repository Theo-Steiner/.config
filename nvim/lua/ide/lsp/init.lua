return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"folke/neoconf.nvim",
		'folke/neodev.nvim',
		'hrsh7th/cmp-nvim-lsp',
	},
	config = function()
		require("neoconf").setup({})
		require("neodev").setup({})
		require("mason").setup()
		-- a list of default servers
		local default_servers = {
			'html',
			'cssls',
			'tsserver',
			'svelte',
			'lua_ls',
			'volar',
			'jsonls',
			'emmet_ls',
		}

		require('mason-lspconfig').setup({
			ensure_installed = default_servers
		})
		local lspconfig = require('lspconfig')

		local settings = require("ide.lsp.server_settings")

		require('mason-lspconfig').setup_handlers({
			function(server_name)
				if settings.client_disabled(server_name) then
					return
				end
				lspconfig[server_name].setup(
					settings.get_config(server_name)
				)
			end,
		})
	end,
}
