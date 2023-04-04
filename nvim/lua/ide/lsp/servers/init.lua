local M = {}

-- list of servers that I always want installed
M.default_servers = {
	'html',
	'cssls',
	'tsserver',
	'svelte',
	'lua_ls',
	'volar',
	'jsonls',
	'emmet_ls',
}

local server_settings = {
	emmet_ls = require("ide.lsp.servers.emmet_ls"),
	volar = require("ide.lsp.servers.volar"),
	lua_ls = require("ide.lsp.servers.lua_lsp"),
	jsonls = require("ide.lsp.servers.jsonls")
}

-- easily disable lsps in .neoconf.json like this
-- {
-- "tsserver": { "disable": true }
-- }
M.is_disabled = function(client)
	require("neoconf").get(client .. ".disable")
end

M.setup = function()
	local default_capabilities = require('cmp_nvim_lsp').default_capabilities()
	local auto_format = require("ide.formatting").auto_format
	local lsp_attach = function(client, bufnr)
		-- add aucmd for auto formatting
		auto_format(client, bufnr)
		-- Create your keybindings here...
		local surround = function(cmd)
			return string.format('<cmd>lua vim.lsp.%s<cr>', cmd)
		end


		vim.keymap.set('n', 'K', surround('buf.hover()'))
		vim.keymap.set('n', 'gD', surround('buf.declaration()'))
		vim.keymap.set('n', 'gi', surround('buf.implementation()'))
		vim.keymap.set('n', 's', surround('buf.rename()'))
		vim.keymap.set('n', 'ga', surround('buf.code_action()'))
	end

	M.get_config = function(server_name)
		return vim.tbl_extend(
			"keep",
			server_settings[server_name] or {},
			{
				on_attach = lsp_attach,
				capabilities = default_capabilities
			}
		)
	end
end

return M
