local M = {}
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
				globals = { "vim", "use", "AUTO_FORMAT", "Set" },
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

-- easily disable lsps in .neoconf.json like this
-- {
-- "tsserver": { "disable": true }
-- }
M.client_disabled = function(client)
	require("neoconf").get(client .. ".disable")
end

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

return M
