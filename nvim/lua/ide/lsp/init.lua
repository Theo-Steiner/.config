return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"folke/neoconf.nvim",
		'folke/neodev.nvim',
		'hrsh7th/cmp-nvim-lsp',
		"pmizio/typescript-tools.nvim",
	},
	config = function()
		require("neoconf").setup({})
		require("neodev").setup({})
		require("mason").setup()
		local server_settings = require("ide.lsp.servers")

		require('mason-lspconfig').setup({
			ensure_installed = server_settings.default_servers
		})
		local lspconfig = require('lspconfig')

		server_settings.setup()

		require('mason-lspconfig').setup_handlers({
			function(server_name)
				if server_settings.is_disabled(server_name) then
					return
				end
				lspconfig[server_name].setup(
					server_settings.get_config(server_name)
				)
			end,
		})

		-- since we're using typescript-tools.nvim instead of the plain tsserver
		-- it can't be installed by mason and thus needs special handling
		if not server_settings.is_disabled("tsserver") then
			require("typescript-tools").setup(
				server_settings.get_config("tsserver")
			)
		end

		-- setup diagnostics
		require("ide.lsp.diagnostics").setup()
	end,
}
