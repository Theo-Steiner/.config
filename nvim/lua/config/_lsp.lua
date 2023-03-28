local get_filetypes = function(server_name)
	local modified_filetypes
	if server_name == "emmet_ls" then
		modified_filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'vue', 'css', 'sass', 'scss', 'less' }
	end
	if server_name == "volar" then
		modified_filetypes = { 'vue', 'typescript', 'javascript' }
	end
	return modified_filetypes
end

return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
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

		-- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
		local lsp_attach = function(client, bufnr)
			-- add aucmd for auto formatting
			AUTO_FORMAT(client, bufnr)
			-- Create your keybindings here...
			local surround = function(cmd)
				return string.format('<cmd>lua vim.lsp.%s<cr>', cmd)
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
				lspconfig[server_name].setup({
					on_attach = lsp_attach,
					filetypes = get_filetypes(server_name),
					capabilities = lsp_capabilities,
				})
			end,
		})
	end,
}
