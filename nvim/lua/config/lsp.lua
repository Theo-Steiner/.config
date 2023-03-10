-- ****************************************
-- ************** Formatting **************
-- ****************************************

-- add global to track if auto formatting is enabled
vim.g.AutoFormattingEnabled = true

-- add commands for to format and toggle auto formatting
vim.cmd([[command! F lua vim.g.AutoFormattingEnabled = not vim.g.AutoFormattingEnabled]])
vim.cmd([[command! Formatting lua vim.g.AutoFormattingEnabled = not vim.g.AutoFormattingEnabled]])
vim.cmd([[command! Fmt lua vim.lsp.buf.format()]])
vim.cmd([[command! Format lua vim.lsp.buf.format()]])

-- filter what servers are used to format
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- servers that should be used for formatting go here
			return client.name == "null-ls" or client.name == "lua_ls"
		end,
		bufnr = bufnr,
	})
	-- keep gitsigns in sync after formatting
	require("gitsigns").refresh()
end

-- augroup for formatting
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- attach this handler as on_attach callback to enable lsp autoformatting
AUTO_FORMAT = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				if vim.g.AutoFormattingEnabled then
					lsp_formatting(bufnr)
				end
			end,
		})
	end
end

-- ****************************************
-- ************** Completions *************
-- ****************************************

-- configure lsp-zero, a wrapper around nvim-cmp for n00bs like me
require("config._lsp-zero")

-- configure null-ls, a "fake language server that allows processes
-- like prettier/eslint to hook into nvim's lsp-service
require("config._null-ls")

-- ****************************************
-- ************** Keybindings *************
-- ****************************************

-- LSP actions
-- show information about code at cursor position
Map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
--
Map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
Map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
Map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
Map("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
Map("n", "gr", "<cmd>TroubleToggle lsp_references<cr>")
Map("n", "s", "<cmd>lua vim.lsp.buf.rename()<cr>")
Map("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>")

-- Diagnostics
Map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
