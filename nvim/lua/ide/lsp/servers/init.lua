local M = {}

-- list of servers that I always want installed
M.default_servers = {
	"html",
	"cssls",
	-- 'tsserver' is installed via "pmizio/typescript-tools.nvim"
	"svelte",
	"lua_ls",
	"volar",
	"jsonls",
	"emmet_ls",
}

local server_settings = {
	emmet_ls = require("ide.lsp.servers.emmet_ls"),
	volar = require("ide.lsp.servers.volar"),
	lua_ls = require("ide.lsp.servers.lua_lsp"),
	jsonls = require("ide.lsp.servers.jsonls"),
	tsserver = require("ide.lsp.servers.tsserver"),
}

-- easily disable lsps in .neoconf.json like this
-- {
-- "tsserver": { "disable": true }
-- }
M.is_disabled = function(client)
	return require("neoconf").get(client .. ".disable")
end

local get_server_settings = function(server_name)
	-- don't add ts to volar filetypes if tsserver is not explicitly disabled
	if server_name == "volar" then
		if not M.is_disabled("tsserver") then
			return {}
		end
	end
	-- return standard server settings in all other cases
	return server_settings[server_name] or {}
end

-- server_settings.setup()
M.setup = function()
	local default_capabilities = require("cmp_nvim_lsp").default_capabilities()
	local lsp_attach = function(client, bufnr)
		-- helper
		local surround_helper = function(cmd)
			return string.format("<cmd>lua vim.lsp.%s<cr>", cmd)
		end
		vim.keymap.set("n", "K", surround_helper("buf.hover()"))
		vim.keymap.set("n", "gD", surround_helper("buf.declaration()"))
		vim.keymap.set("n", "gi", surround_helper("buf.implementation()"))
		vim.keymap.set("n", "s", surround_helper("buf.rename()"))
		vim.keymap.set("n", "ga", surround_helper("buf.code_action()"))
	end

	M.get_config = function(server_name)
		return vim.tbl_extend("keep", get_server_settings(server_name), {
			on_attach = lsp_attach,
			capabilities = default_capabilities,
		})
	end
end

return M
