local M = {}

-- list of servers that I always want installed
M.default_servers = {
	"html",
	"cssls",
	"ts_ls",
	-- disabled by default (special case in is_disabled)
	"denols",
	"svelte",
	"lua_ls",
	"volar",
	"gopls",
	"jsonls",
	"emmet_ls",
}

local server_settings = {
	emmet_ls = require("ide.lsp.servers.emmet_ls"),
	volar = require("ide.lsp.servers.volar"),
	lua_ls = require("ide.lsp.servers.lua_ls"),
	jsonls = require("ide.lsp.servers.jsonls"),
	ts_ls = require("ide.lsp.servers.ts_ls"),
	gopls = require("ide.lsp.servers.gopls"),
}

-- easily disable lsps in project root .neoconf.json like this
-- {
-- "gopls": { "disable": true }
-- }
M.is_disabled = function(server_name)
	local neoconf = require("neoconf")
	-- special case: deno is disabled by default, and only enabled if
	-- 'ts_ls' is disabled and 'denols' is explicitlty enabled
	-- {
	--   "ts_ls":  { "disable": true }
	--   "denols": { "enable": true }
	-- }
	if server_name == "denols" then
		return not neoconf.get("ts_ls.disable") and neoconf.get("denols.enable")
	end
	return neoconf.get(server_name .. ".disable")
end

local get_server_settings = function(server_name)
	return server_settings[server_name] or {}
end

-- server_settings.setup()
M.setup = function()
	local default_capabilities = require("cmp_nvim_lsp").default_capabilities()
	local lsp_attach = function(_, _)
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
