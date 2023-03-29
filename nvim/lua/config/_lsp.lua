local runtime_path = vim.split(package.path, ";", {})
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local server_settings = {
	emmet_ls = {
		filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'vue', 'css', 'sass', 'scss', 'less' },
	},
	volar = {
		filetypes = { 'vue', 'typescript', 'javascript' }
	},
	lua_ls = {
		settings = {
			format = {
				enable = true,
				defaultConfig = { indent_style = "space", indent_size = 2 },
			},
			diagnostics = {
				globals = { "vim", "use", "AUTO_FORMAT", "Set", "Map" },
			},
			runtime = { version = "LuaJIT", path = runtime_path },
			workspace = {
				library = {
					vim.fn.expand("$VIMRUNTIME/lua"),
				},
			},
		}
	}
}

return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"folke/neoconf.nvim",
		'folke/neodev.nvim',
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

		local lsp_attach = function(client, bufnr)
			-- add aucmd for auto formatting
			AUTO_FORMAT(client, bufnr)
			-- Create your keybindings here...
			local surround = function(cmd)
				return string.format('<cmd>lua vim.lsp.%s<cr>', cmd)
			end
			-- easily disable lsp in .neoconf.json like this
			-- {
			-- "tsserver": { "disable": true }
			-- }
			local client_disable = require("neoconf").get(client.name .. ".disable")
			if client_disable then
				vim.lsp.stop_client(vim.lsp.get_active_clients({ name = client.name }), true)
			end
			Map('n', 'K', surround('buf.hover()'))
			Map('n', 'gD', surround('buf.declaration()'))
			Map('n', 'gi', surround('buf.implementation()'))
			Map('n', 's', surround('buf.rename()'))
			Map('n', 'ga', surround('buf.code_action()'))
		end

		local lspconfig = require('lspconfig')
		require('mason-lspconfig').setup_handlers({
			function(server_name)
				local server_config = vim.tbl_extend(
					"keep",
					server_settings[server_name] or {},
					{ on_attach = lsp_attach }
				)
				lspconfig[server_name].setup(
					server_config
				)
			end,
		})
	end,
}
