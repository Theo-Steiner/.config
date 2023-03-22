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
